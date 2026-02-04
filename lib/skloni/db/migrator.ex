defmodule Skloni.DB.Migrator do
  @moduledoc false

  alias Skloni.DB.Mnesia
  alias Skloni.DB.Tables
  alias Skloni.DB.Tables.MigrationVersions

  @compile {:no_warn_undefined, :mnesia}

  @migrations [
    {20_260_203_000_000, Skloni.DB.Migrations.CreateResultsTables},
    {20_260_204_000_000, Skloni.DB.Migrations.CreateUsersTables}
  ]

  def run! do
    ensure_system_tables()

    applied_versions = applied_versions()

    Enum.each(@migrations, fn {version, module} ->
      if version not in applied_versions do
        :ok = module.up()
        record = %MigrationVersions{id: version, inserted_at: DateTime.utc_now()}
        Mnesia.write_struct!(record, MigrationVersions)
      end
    end)
  end

  defp ensure_system_tables do
    Tables.system_tables()
    |> Enum.each(fn table_module ->
      :ok = table_module.create_table()
    end)

    :ok =
      :mnesia.wait_for_tables(
        [MigrationVersions.table_name(), Skloni.DB.Tables.Counters.table_name()],
        5_000
      )
  end

  defp applied_versions do
    match_spec = Mnesia.where(MigrationVersions, %{})

    MigrationVersions
    |> Mnesia.select_structs(match_spec)
    |> Enum.map(& &1.id)
  end
end
