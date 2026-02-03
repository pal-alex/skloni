defmodule Skloni.DB.Tables.TestResults do
  @moduledoc false

  alias Skloni.DB.Mnesia

  @record_name :test_results
  @attributes [:id, :user_id, :started_at, :finished_at, :passed_qty, :errors_qty]

  defstruct @attributes

  def record_name, do: @record_name
  def table_name, do: @record_name
  def attributes, do: @attributes
  def record_struct, do: %__MODULE__{}

  def create_table do
    Mnesia.create_table(@record_name, @attributes, disc_copies: [node()])
  end
end
