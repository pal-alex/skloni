defmodule Skloni.TestsOrderTest do
  use ExUnit.Case, async: true

  alias Skloni.DB.Tables.TaskResults
  alias Skloni.Tests

  defp build_task(case_name, number, gender) do
    %{case: case_name, number: number, gender: gender, parts: []}
  end

  test "orders never passed before never attempted" do
    user_id = Tests.default_user_id()
    first = build_task(:imenovalnik, :ednina, :moski)
    second = build_task(:rodilnik, :ednina, :zenski)

    results = [
      %TaskResults{
        id: Tests.task_result_id(user_id, first),
        user_id: user_id,
        sklon: first.case,
        number: first.number,
        gender: first.gender,
        passed_qty: 0,
        errors_qty: 2
      }
    ]

    ordered = Tests.order_tasks([first, second], results, user_id)

    assert Enum.at(ordered, 0) == first
    assert Enum.at(ordered, 1) == second
  end

  test "orders by error rate for attempted tasks" do
    user_id = Tests.default_user_id()
    high_error = build_task(:dajalnik, :dvojina, :moski)
    low_error = build_task(:tozhilnik, :mnozina, :zenski)

    results = [
      %TaskResults{
        id: Tests.task_result_id(user_id, high_error),
        user_id: user_id,
        sklon: high_error.case,
        number: high_error.number,
        gender: high_error.gender,
        passed_qty: 2,
        errors_qty: 2
      },
      %TaskResults{
        id: Tests.task_result_id(user_id, low_error),
        user_id: user_id,
        sklon: low_error.case,
        number: low_error.number,
        gender: low_error.gender,
        passed_qty: 3,
        errors_qty: 0
      }
    ]

    ordered = Tests.order_tasks([low_error, high_error], results, user_id)

    assert Enum.at(ordered, 0) == high_error
    assert Enum.at(ordered, 1) == low_error
  end
end
