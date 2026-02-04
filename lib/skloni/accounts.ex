defmodule Skloni.Accounts do
  @moduledoc false

  alias Skloni.DB.Mnesia
  alias Skloni.DB.Tables.{Counters, UserTokens, Users}

  @session_context "session"
  @session_max_age 60 * 60 * 24 * 60

  def session_max_age, do: @session_max_age

  def get_user(id) when is_integer(id) do
    Mnesia.get_struct(Users, id)
  end

  def get_user(_id), do: nil

  def get_user_by_google_sub(sub) when is_binary(sub) do
    match_spec = Mnesia.where(Users, %{google_sub: sub})

    Users
    |> Mnesia.select_structs(match_spec)
    |> List.first()
  end

  def get_user_by_google_sub(_sub), do: nil

  def upsert_google_user(%Ueberauth.Auth{} = auth) do
    sub = auth.uid
    info = auth.info
    now = DateTime.utc_now()

    if is_binary(sub) do
      case get_user_by_google_sub(sub) do
        nil ->
          user_id = Counters.next_id(:users)

          user = %Users{
            id: user_id,
            google_sub: sub,
            email: info.email,
            first_name: info.first_name,
            last_name: info.last_name,
            avatar_url: info.image,
            locale: info.locale,
            created_at: now,
            last_login_at: now
          }

          :ok = Mnesia.write_struct!(user, Users)
          {:ok, user}

        user ->
          updated = %Users{
            user
            | email: info.email || user.email,
              first_name: info.first_name || user.first_name,
              last_name: info.last_name || user.last_name,
              avatar_url: info.image || user.avatar_url,
              locale: info.locale || user.locale,
              last_login_at: now
          }

          :ok = Mnesia.write_struct!(updated, Users)
          {:ok, updated}
      end
    else
      {:error, :missing_subject}
    end
  end

  def create_session_token(%Users{id: user_id}) do
    token = build_token()
    hash = token_hash(token)
    now = DateTime.utc_now()

    record = %UserTokens{
      id: hash,
      user_id: user_id,
      context: @session_context,
      inserted_at: now,
      last_used_at: now
    }

    :ok = Mnesia.write_struct!(record, UserTokens)
    token
  end

  def delete_session_token(token) when is_binary(token) do
    hash = token_hash(token)

    _ =
      Mnesia.transaction(fn ->
        :mnesia.delete(UserTokens.table_name(), hash, :write)
      end)

    :ok
  end

  def delete_session_token(_token), do: :ok

  def get_user_by_session_token(token) when is_binary(token) do
    hash = token_hash(token)
    now = DateTime.utc_now()

    {:atomic, result} =
      Mnesia.transaction(fn ->
        case :mnesia.read(UserTokens.table_name(), hash, :write) do
          [record] ->
            token_record = Skloni.DB.Utils.record_to_struct(record, UserTokens)

            if expired?(token_record, now) do
              :mnesia.delete(UserTokens.table_name(), hash, :write)
              {:expired, nil}
            else
              updated = %UserTokens{token_record | last_used_at: now}
              :ok = Mnesia.write_struct(updated, UserTokens)
              {:ok, token_record.user_id}
            end

          [] ->
            {:error, nil}
        end
      end)

    case result do
      {:ok, user_id} -> get_user(user_id)
      _ -> nil
    end
  end

  def get_user_by_session_token(_token), do: nil

  def display_name(%Users{} = user) do
    cond do
      present?(user.first_name) and present?(user.last_name) ->
        "#{user.first_name} #{user.last_name}"

      present?(user.first_name) ->
        user.first_name

      present?(user.last_name) ->
        user.last_name

      present?(user.email) ->
        user.email

      true ->
        "Learner"
    end
  end

  defp build_token do
    32
    |> :crypto.strong_rand_bytes()
    |> Base.url_encode64(padding: false)
  end

  defp token_hash(token) do
    :crypto.hash(:sha256, token)
  end

  defp expired?(%UserTokens{inserted_at: inserted_at}, now) do
    DateTime.diff(now, inserted_at, :second) > @session_max_age
  end

  defp present?(value) when is_binary(value), do: String.trim(value) != ""
  defp present?(_value), do: false
end
