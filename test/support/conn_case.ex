defmodule SkloniWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  we enable the SQL sandbox, so changes done to the database
  are reverted at the end of every test. If you are using
  PostgreSQL, you can even run database tests asynchronously
  by setting `use SkloniWeb.ConnCase, async: true`, although
  this option is not recommended for other databases.
  """

  use ExUnit.CaseTemplate

  alias Skloni.DB.Mnesia
  alias Skloni.DB.Tables.{Counters, Users}
  alias SkloniWeb.UserAuth

  using do
    quote do
      # The default endpoint for testing
      @endpoint SkloniWeb.Endpoint

      use SkloniWeb, :verified_routes

      # Import conveniences for testing with connections
      import Plug.Conn
      import Phoenix.ConnTest
      import SkloniWeb.ConnCase
    end
  end

  setup _tags do
    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end

  def register_user(attrs \\ %{}) do
    now = DateTime.utc_now()

    user = %Users{
      id: Counters.next_id(:users),
      google_sub: Map.get(attrs, :google_sub, "test-sub"),
      email: Map.get(attrs, :email, "test@example.com"),
      first_name: Map.get(attrs, :first_name, "Test"),
      last_name: Map.get(attrs, :last_name, "User"),
      avatar_url: Map.get(attrs, :avatar_url, nil),
      locale: Map.get(attrs, :locale, "en"),
      created_at: now,
      last_login_at: now
    }

    :ok = Mnesia.write_struct!(user, Users)
    user
  end

  def log_in_user(conn, user) do
    conn
    |> Phoenix.ConnTest.init_test_session(%{})
    |> UserAuth.log_in_user(user)
  end

  def login_and_return_user(conn, attrs \\ %{}) do
    user = register_user(attrs)
    {log_in_user(conn, user), user}
  end
end
