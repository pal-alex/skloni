defmodule Skloni.DB.Tables.Counters do
  @moduledoc false

  alias Skloni.DB.Mnesia

  @compile {:no_warn_undefined, :mnesia}

  @record_name :counters
  @attributes [:id, :value]

  defstruct @attributes

  def record_name, do: @record_name
  def table_name, do: @record_name
  def attributes, do: @attributes
  def record_struct, do: %__MODULE__{}

  def create_table do
    Mnesia.create_table(@record_name, @attributes, disc_copies: [node()])
  end

  def next_id(counter_id) do
    {:atomic, value} =
      :mnesia.transaction(fn ->
        case :mnesia.read(@record_name, counter_id, :write) do
          [] ->
            :mnesia.write({@record_name, counter_id, 1})
            1

          [{@record_name, ^counter_id, current}] ->
            next = current + 1
            :mnesia.write({@record_name, counter_id, next})
            next
        end
      end)

    value
  end
end
