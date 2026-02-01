defmodule Skloni.Tasks.Tozhilnik do
  @moduledoc false

  def tests do
    [
      test(:ednina, :moski, parts(["Vidim dobr", {:field, "ega"}, " koleg", {:field, "a"}, "."])),
      test(
        :ednina,
        :zenski,
        parts(["Vidim dobr", {:field, "o"}, " prijateljic", {:field, "o"}, "."])
      ),
      test(:ednina, :srednji, parts(["Vidim dobr", {:field, "o"}, " dekl", {:field, "e"}, "."])),
      test(:dvojina, :moski, parts(["Vidiva dobr", {:field, "a"}, " koleg", {:field, "a"}, "."])),
      test(
        :dvojina,
        :zenski,
        parts(["Vidiva dobr", {:field, "i"}, " prijateljic", {:field, "i"}, "."])
      ),
      test(
        :dvojina,
        :srednji,
        parts(["Vidiva dobr", {:field, "i"}, " dekl", {:field, "i"}, "."])
      ),
      test(:mnozina, :moski, parts(["Vidimo dobr", {:field, "e"}, " koleg", {:field, "e"}, "."])),
      test(
        :mnozina,
        :zenski,
        parts(["Vidimo dobr", {:field, "e"}, " prijateljic", {:field, "e"}, "."])
      ),
      test(:mnozina, :srednji, parts(["Vidimo dobr", {:field, "a"}, " dekl", {:field, "a"}, "."]))
    ]
  end

  defp test(number, gender, parts) do
    %{case: :tozhilnik, number: number, gender: gender, parts: parts}
  end

  defp parts(items) do
    Enum.map(items, fn
      {:field, value} -> %{field: value}
      text -> %{text: text}
    end)
  end
end
