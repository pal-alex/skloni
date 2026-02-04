defmodule SkloniWeb.AuthController do
  use SkloniWeb, :controller

  plug Ueberauth

  alias Skloni.Accounts
  alias SkloniWeb.UserAuth

  def request(conn, _params), do: conn

  def callback(%{assigns: %{ueberauth_failure: failure}} = conn, _params) do
    message = failure_message(failure)

    conn
    |> put_flash(:error, message)
    |> redirect(to: ~p"/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    case Accounts.upsert_google_user(auth) do
      {:ok, user} ->
        conn
        |> UserAuth.log_in_user(user)
        |> put_flash(:info, "Welcome back, #{Accounts.display_name(user)}!")
        |> redirect(to: ~p"/")

      {:error, _reason} ->
        conn
        |> put_flash(:error, "We couldn't sign you in with Google.")
        |> redirect(to: ~p"/")
    end
  end

  def delete(conn, _params) do
    conn
    |> UserAuth.log_out_user()
    |> put_flash(:info, "You have been logged out.")
    |> redirect(to: ~p"/")
  end

  defp failure_message(failure) do
    case failure.errors do
      [%{message: message} | _] when is_binary(message) ->
        "Google sign-in failed: #{message}"

      _ ->
        "Google sign-in failed. Please try again."
    end
  end
end
