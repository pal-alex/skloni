defmodule Skloni.DB.Utils do
  @moduledoc false

  def struct_to_record(struct, table_module) do
    values =
      table_module.attributes()
      |> Enum.map(&Map.get(struct, &1))

    List.to_tuple([table_module.record_name() | values])
  end

  def record_to_struct(record, table_module) do
    [_name | values] = Tuple.to_list(record)
    attrs = table_module.attributes()
    struct = table_module.record_struct()

    attrs
    |> Enum.zip(values)
    |> Enum.reduce(struct, fn {attr, value}, acc ->
      Map.put(acc, attr, value)
    end)
  end
end
