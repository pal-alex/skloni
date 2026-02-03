defmodule Skloni.DB.Migrations.CreateResultsTables do
  @moduledoc false

  alias Skloni.DB.Tables

  def up do
    Tables.domain_tables()
    |> Enum.each(fn table_module ->
      :ok = table_module.create_table()
    end)

    :ok
  end
end
