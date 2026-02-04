defmodule Skloni.DB.Tables.UserTokens do
  @moduledoc false

  alias Skloni.DB.Mnesia

  @record_name :user_tokens
  @attributes [:id, :user_id, :context, :inserted_at, :last_used_at]

  defstruct @attributes

  def record_name, do: @record_name
  def table_name, do: @record_name
  def attributes, do: @attributes
  def record_struct, do: %__MODULE__{}

  def create_table do
    Mnesia.create_table(@record_name, @attributes, disc_copies: [node()])
  end
end
