defmodule Skloni.Tests do
  @moduledoc false

  alias Skloni.DB.Mnesia
  alias Skloni.DB.Tables.{Counters, TaskResults, TestResults}
  alias Skloni.Tasks

  @compile {:no_warn_undefined, :mnesia}

  def default_user_id, do: nil

  def start_test(user_id) do
    test_id = Counters.next_id(:test_results)

    record = %TestResults{
      id: test_id,
      user_id: user_id,
      started_at: DateTime.utc_now(),
      finished_at: nil,
      passed_qty: 0,
      errors_qty: 0
    }

    Mnesia.write_struct!(record, TestResults)
    test_id
  end

  def record_test_attempt(test_id, correct?) do
    {:atomic, _} =
      Mnesia.transaction(fn ->
        case :mnesia.read(TestResults.table_name(), test_id, :write) do
          [record] ->
            test = Skloni.DB.Utils.record_to_struct(record, TestResults)

            updated = %TestResults{
              test
              | passed_qty: test.passed_qty + if(correct?, do: 1, else: 0),
                errors_qty: test.errors_qty + if(correct?, do: 0, else: 1)
            }

            Mnesia.write_struct(updated, TestResults)
            {:ok, updated}

          [] ->
            {:error, :not_found}
        end
      end)

    :ok
  end

  def finish_test(test_id) do
    {:atomic, _} =
      Mnesia.transaction(fn ->
        case :mnesia.read(TestResults.table_name(), test_id, :write) do
          [record] ->
            test = Skloni.DB.Utils.record_to_struct(record, TestResults)

            updated =
              if is_nil(test.finished_at) do
                %TestResults{test | finished_at: DateTime.utc_now()}
              else
                test
              end

            Mnesia.write_struct(updated, TestResults)
            {:ok, updated}

          [] ->
            {:error, :not_found}
        end
      end)

    :ok
  end

  def record_task_attempt(user_id, task, correct?) do
    id = task_result_id(user_id, task)

    {:atomic, _} =
      Mnesia.transaction(fn ->
        case :mnesia.read(TaskResults.table_name(), id, :write) do
          [] ->
            record = %TaskResults{
              id: id,
              user_id: user_id,
              sklon: task.case,
              number: task.number,
              gender: task.gender,
              passed_qty: if(correct?, do: 1, else: 0),
              errors_qty: if(correct?, do: 0, else: 1)
            }

            Mnesia.write_struct(record, TaskResults)
            {:ok, record}

          [record] ->
            result = Skloni.DB.Utils.record_to_struct(record, TaskResults)

            updated = %TaskResults{
              result
              | passed_qty: result.passed_qty + if(correct?, do: 1, else: 0),
                errors_qty: result.errors_qty + if(correct?, do: 0, else: 1)
            }

            Mnesia.write_struct(updated, TaskResults)
            {:ok, updated}
        end
      end)

    :ok
  end

  def list_task_results(user_id) do
    match_spec = Mnesia.where(TaskResults, %{user_id: user_id})
    Mnesia.select_structs(TaskResults, match_spec)
  end

  def build_test_tasks(user_id) do
    tasks = Tasks.all_tasks()
    results = list_task_results(user_id)
    order_tasks(tasks, results, user_id)
  end

  def order_tasks(tasks, results, user_id) do
    results_by_id =
      results
      |> Enum.map(fn result -> {result.id, result} end)
      |> Map.new()

    tasks
    |> Enum.map(fn task ->
      id = task_result_id(user_id, task)
      result = Map.get(results_by_id, id)
      attempts = attempts_count(result)
      error_rate = error_rate(result)

      group_rank =
        cond do
          attempts > 0 and passed_count(result) == 0 -> 0
          attempts == 0 -> 1
          true -> 2
        end

      %{
        task: task,
        group_rank: group_rank,
        error_rate: error_rate,
        tiebreaker: :rand.uniform()
      }
    end)
    |> Enum.sort_by(fn entry ->
      {entry.group_rank, -entry.error_rate, entry.tiebreaker}
    end)
    |> Enum.map(& &1.task)
  end

  def task_result_id(user_id, task) do
    {user_id, task.case, task.number, task.gender}
  end

  defp attempts_count(nil), do: 0

  defp attempts_count(result) do
    result.passed_qty + result.errors_qty
  end

  defp passed_count(nil), do: 0
  defp passed_count(result), do: result.passed_qty

  defp error_rate(nil), do: 0.0

  defp error_rate(result) do
    attempts = attempts_count(result)

    if attempts == 0 do
      0.0
    else
      result.errors_qty / attempts
    end
  end
end
