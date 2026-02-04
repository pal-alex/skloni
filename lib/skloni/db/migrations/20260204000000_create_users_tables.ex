defmodule Skloni.DB.Migrations.CreateUsersTables do
  @moduledoc false

  alias Skloni.DB.Tables

  def up do
    Tables.user_tables()
    |> Enum.each(fn table_module ->
      :ok = table_module.create_table()
    end)

    :ok
  end
end
