defmodule SkloniWeb.InflectionLiveTest do
  use SkloniWeb.ConnCase, async: false

  import Phoenix.LiveViewTest
  import ExUnit.CaptureLog

  alias Skloni.DB.Mnesia

  setup do
    start_supervised!(Skloni.Mnesia)
    :ok = Skloni.DB.Tables.TaskResults.create_table()
    :ok = Skloni.DB.Tables.TestResults.create_table()

    :ok = :mnesia.wait_for_tables([:task_results, :test_results, :counters], 5_000)
    :ok = Mnesia.clear_table(:task_results)
    :ok = Mnesia.clear_table(:test_results)
    :ok = Mnesia.clear_table(:counters)
    :ok
  end

  test "starts a test run on click", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/")

    refute has_element?(view, "#inflection-answer:not([disabled])")

    _ = render_click(element(view, "#start-test"))

    assert has_element?(view, "#inflection-answer:not([disabled])")
  end

  test "raises on stale results schema before starting", %{conn: conn} do
    case :mnesia.delete_table(:test_results) do
      {:atomic, :ok} -> :ok
      {:aborted, :no_exists} -> :ok
    end

    {:atomic, :ok} =
      :mnesia.create_table(
        :test_results,
        attributes: [:id, :user_id, :sklon, :number, :gender, :passed_qty, :errors_qty],
        disc_copies: [node()]
      )

    :ok = :mnesia.wait_for_tables([:test_results], 5_000)

    {:ok, view, _html} = live(conn, ~p"/")

    Process.flag(:trap_exit, true)
    Process.unlink(view.pid)

    capture_log(fn ->
      reason = catch_exit(render_click(element(view, "#start-test")))
      {{%RuntimeError{message: message}, _}, _} = reason
      assert String.contains?(message, "rebuild_domain")
    end)

    _ = :mnesia.delete_table(:test_results)

    {:atomic, :ok} =
      :mnesia.create_table(
        :test_results,
        attributes: Skloni.DB.Tables.TestResults.attributes(),
        disc_copies: [node()]
      )

    :ok = :mnesia.wait_for_tables([:test_results], 5_000)
  end
end
