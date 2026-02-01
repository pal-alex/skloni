defmodule Skloni.Tasks do
  @moduledoc false

  alias Skloni.Tasks.{
    Dajalnik,
    Imenovalnik,
    Mestnik,
    Orodnik,
    Rodilnik,
    Tozhilnik
  }

  def all_tests do
    [
      Imenovalnik,
      Rodilnik,
      Dajalnik,
      Tozhilnik,
      Mestnik,
      Orodnik
    ]
    |> Enum.flat_map(& &1.tests())
  end

  def expected_endings(parts) do
    parts
    |> Enum.filter(&Map.has_key?(&1, :field))
    |> Enum.map(&(&1.field || ""))
  end
end
