defmodule Skloni.DB.Mnesia do
  @moduledoc false

  alias Skloni.DB.Utils

  @compile {:no_warn_undefined, :mnesia}

  def transaction(fun) when is_function(fun, 0) do
    :mnesia.transaction(fun)
  end

  def create_table(table, attributes, opts) do
    case :mnesia.create_table(table, Keyword.merge([attributes: attributes], opts)) do
      {:atomic, :ok} ->
        :ok

      {:aborted, {:already_exists, ^table}} ->
        :ok

      {:aborted, reason} ->
        {:error, reason}
    end
  end

  def write_record!(record) do
    case :mnesia.transaction(fn -> :mnesia.write(record) end) do
      {:atomic, :ok} ->
        :ok

      {:aborted, {:bad_type, _}} ->
        raise RuntimeError,
              "Mnesia table schema mismatch. Run `mix skloni.db.rebuild_domain_with_data` to preserve data, `mix skloni.db.rebuild_domain` to reset, or add a migration."

      {:aborted, reason} ->
        raise MatchError, term: {:aborted, reason}
    end
  end

  def write_record(record) do
    :ok = :mnesia.write(record)
    :ok
  end

  def read_record(table, key) do
    {:atomic, result} = :mnesia.transaction(fn -> :mnesia.read(table, key) end)

    case result do
      [record] -> record
      _ -> nil
    end
  end

  def select_records(table, match_spec) do
    {:atomic, records} = :mnesia.transaction(fn -> :mnesia.select(table, match_spec) end)
    records
  end

  def clear_table(table) do
    :mnesia.clear_table(table)
    :ok
  end

  def write_struct!(struct, table_module) do
    struct
    |> Utils.struct_to_record(table_module)
    |> write_record!()
  end

  def write_struct(struct, table_module) do
    struct
    |> Utils.struct_to_record(table_module)
    |> write_record()
  end

  def get_struct(table_module, key) do
    case read_record(table_module.table_name(), key) do
      nil -> nil
      record -> Utils.record_to_struct(record, table_module)
    end
  end

  def select_structs(table_module, match_spec) do
    table_module.table_name()
    |> select_records(match_spec)
    |> Enum.map(&Utils.record_to_struct(&1, table_module))
  end

  def where(table_module, filters) when is_map(filters) do
    attrs = table_module.attributes()

    values =
      Enum.map(attrs, fn attr ->
        Map.get(filters, attr, :_)
      end)

    pattern = List.to_tuple([table_module.record_name() | values])
    [{pattern, [], [:"$_"]}]
  end
end
