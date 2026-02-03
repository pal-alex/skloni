defmodule Skloni.TestsMnesiaTest do
  use ExUnit.Case, async: false

  alias Skloni.DB.Mnesia
  alias Skloni.DB.Tables.TestResults
  alias Skloni.Tests

  setup do
    start_supervised!(Skloni.Mnesia)

    _ = :mnesia.delete_table(:task_results)
    _ = :mnesia.delete_table(:test_results)

    :ok = Skloni.DB.Tables.TaskResults.create_table()
    :ok = Skloni.DB.Tables.TestResults.create_table()
    :ok = :mnesia.wait_for_tables([:task_results, :test_results], 5_000)

    :ok = Mnesia.clear_table(:task_results)
    :ok = Mnesia.clear_table(:test_results)
    :ok = Mnesia.clear_table(:counters)
    :ok
  end

  test "records attempts and prioritizes previously failed tests" do
    user_id = Tests.default_user_id()
    tasks = Skloni.Tasks.all_tasks()
    [first, second | _] = tasks

    _ = Tests.record_task_attempt(user_id, first, false)

    ordered = Tests.build_test_tasks(user_id)

    first_index = Enum.find_index(ordered, &(&1 == first))
    second_index = Enum.find_index(ordered, &(&1 == second))

    assert first_index < second_index
  end

  test "updates test results totals" do
    user_id = Tests.default_user_id()
    test_id = Tests.start_test(user_id)

    _ = Tests.record_test_attempt(test_id, true)
    _ = Tests.record_test_attempt(test_id, false)

    test = Mnesia.get_struct(TestResults, test_id)

    assert test.passed_qty == 1
    assert test.errors_qty == 1
  end
end
