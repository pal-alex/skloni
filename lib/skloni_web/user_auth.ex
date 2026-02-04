defmodule SkloniWeb.UserAuth do
  @moduledoc false

  alias Plug.Conn
  alias Skloni.Accounts

  @session_key "user_token"

  def fetch_current_user(conn, _opts) do
    token = Conn.get_session(conn, @session_key)
    user = Accounts.get_user_by_session_token(token)

    conn
    |> Conn.assign(:current_user, user)
  end

  def log_in_user(conn, user) do
    token = Accounts.create_session_token(user)

    conn
    |> renew_session()
    |> Conn.put_session(@session_key, token)
  end

  def log_out_user(conn) do
    token = Conn.get_session(conn, @session_key)

    if is_binary(token) do
      :ok = Accounts.delete_session_token(token)
    end

    Conn.configure_session(conn, drop: true)
  end

  def on_mount(:default, _params, session, socket) do
    token = Map.get(session, @session_key)
    user = Accounts.get_user_by_session_token(token)

    {:cont,
     socket
     |> Phoenix.Component.assign(:current_user, user)
     |> Phoenix.Component.assign(:current_scope, scope_for(user))}
  end

  def on_mount(_name, _params, _session, socket) do
    {:cont, socket}
  end

  defp renew_session(conn) do
    conn
    |> Conn.configure_session(renew: true)
    |> Conn.clear_session()
  end

  defp scope_for(nil), do: nil
  defp scope_for(user), do: %{user: user}
end
