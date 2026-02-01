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
    |> Enum.filter(&is_map/1)
    |> Enum.flat_map(fn %{parts: tokens} ->
      Enum.flat_map(tokens, fn
        {:field, value} -> [value]
        _ -> []
      end)
    end)
  end
end
