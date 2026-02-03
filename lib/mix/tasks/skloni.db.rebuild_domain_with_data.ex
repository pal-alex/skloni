defmodule Mix.Tasks.Skloni.Db.RebuildDomainWithData do
  @moduledoc false

  use Mix.Task

  alias Skloni.DB.Tables
  alias Skloni.DB.Tables.MigrationVersions
  alias Skloni.DB.Migrator

  @shortdoc "Rebuilds domain tables while preserving data when possible"

  @impl true
  def run(_args) do
    Mix.Task.run("app.start")

    export = export_domain_tables()
    :ok = rebuild_domain_tables()
    import_domain_tables(export)

    Mix.shell().info("Domain tables rebuilt with data preservation.")
  end

  defp export_domain_tables do
    Tables.domain_tables()
    |> Enum.map(fn table_module ->
      table = table_module.table_name()
      attrs = :mnesia.table_info(table, :attributes)
      records = :mnesia.dirty_select(table, [{:_, [], [:"$_"]}])

      %{table: table, attrs: attrs, records: records}
    end)
  end

  defp rebuild_domain_tables do
    Tables.domain_tables()
    |> Enum.each(fn table_module ->
      _ = :mnesia.delete_table(table_module.table_name())
    end)

    _ = MigrationVersions.create_table()

    case :mnesia.clear_table(MigrationVersions.table_name()) do
      {:atomic, :ok} -> :ok
      {:aborted, {:no_exists, _}} -> :ok
    end

    Migrator.run!()
  end

  defp import_domain_tables(exports) do
    exports
    |> Enum.each(fn %{table: table, attrs: old_attrs, records: records} ->
      new_attrs = :mnesia.table_info(table, :attributes)

      Enum.each(records, fn record ->
        record
        |> record_to_map(old_attrs)
        |> map_to_record(table, new_attrs)
        |> :mnesia.dirty_write()
      end)
    end)
  end

  defp record_to_map(record, attrs) do
    [_table | values] = Tuple.to_list(record)

    attrs
    |> Enum.zip(values)
    |> Map.new()
  end

  defp map_to_record(map, table, attrs) do
    values = Enum.map(attrs, &Map.get(map, &1))
    List.to_tuple([table | values])
  end
end
