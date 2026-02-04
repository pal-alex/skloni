defmodule Skloni.Tasks do
  @moduledoc false

  alias Skloni.Tasks.Format
  alias Skloni.Tests.Skloni

  def all_tasks do
    # Skloni.tasks()
    Skloni.Mnozhina.tasks()
    |> Enum.map(&Format.from_raw_task/1)
  end

  def expected_endings(parts) do
    parts
    |> Enum.filter(&is_map/1)
    |> Enum.flat_map(fn %{parts: tokens} ->
      Enum.flat_map(tokens, fn
        {:field, value} -> [value]
        _ -> []
      end)
    end)
  end

  def task_id(%{test_id: test_id, task_id: task_id}) do
    {test_id, task_id}
  end
end
