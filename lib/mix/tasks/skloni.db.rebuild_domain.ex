defmodule Mix.Tasks.Skloni.Db.RebuildDomain do
  @moduledoc false

  use Mix.Task

  alias Skloni.DB.Tables
  alias Skloni.DB.Tables.MigrationVersions
  alias Skloni.DB.Migrator

  @shortdoc "Rebuilds domain tables (destructive)"

  @impl true
  def run(_args) do
    Mix.Task.run("app.start")

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

    Mix.shell().info("Domain tables rebuilt.")
  end
end
