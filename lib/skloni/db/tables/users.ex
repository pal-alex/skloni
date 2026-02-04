defmodule Skloni.DB.Tables.Users do
  @moduledoc false

  alias Skloni.DB.Mnesia

  @record_name :users
  @attributes [
    :id,
    :google_sub,
    :email,
    :first_name,
    :last_name,
    :avatar_url,
    :locale,
    :created_at,
    :last_login_at
  ]

  defstruct @attributes

  def record_name, do: @record_name
  def table_name, do: @record_name
  def attributes, do: @attributes
  def record_struct, do: %__MODULE__{}

  def create_table do
    Mnesia.create_table(@record_name, @attributes, disc_copies: [node()])
  end
end
