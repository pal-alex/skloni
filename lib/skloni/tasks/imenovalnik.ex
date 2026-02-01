defmodule Skloni.Tasks.Imenovalnik do
  @moduledoc false

  def tests do
    [
      test(:ednina, :moski, parts(["Lep", {:field, "i"}, " koleg", {:field, "a"}, " pride."])),
      test(
        :ednina,
        :zenski,
        parts(["Lep", {:field, "a"}, " prijateljic", {:field, "a"}, " pride."])
      ),
      test(:ednina, :srednji, parts(["Lep", {:field, "o"}, " dekl", {:field, "e"}, " pride."])),
      test(
        :dvojina,
        :moski,
        parts(["Lep", {:field, "a"}, " koleg", {:field, "a"}, " pride", {:field, "ta"}, "."])
      ),
      test(
        :dvojina,
        :zenski,
        parts([
          "Lep",
          {:field, "i"},
          " prijateljic",
          {:field, "i"},
          " pride",
          {:field, "ta"},
          "."
        ])
      ),
      test(
        :dvojina,
        :srednji,
        parts(["Lep", {:field, "i"}, " dekl", {:field, "i"}, " pride", {:field, "ta"}, "."])
      ),
      test(
        :mnozina,
        :moski,
        parts(["Lep", {:field, "i"}, " koleg", {:field, "i"}, " pride", {:field, "jo"}, "."])
      ),
      test(
        :mnozina,
        :zenski,
        parts([
          "Lep",
          {:field, "e"},
          " prijateljic",
          {:field, "e"},
          " pride",
          {:field, "jo"},
          "."
        ])
      ),
      test(
        :mnozina,
        :srednji,
        parts(["Lep", {:field, "a"}, " dekl", {:field, "a"}, " pride", {:field, "jo"}, "."])
      )
    ]
  end

  defp test(number, gender, parts) do
    %{case: :imenovalnik, number: number, gender: gender, parts: parts}
  end

  defp parts(items) do
    Enum.map(items, fn
      {:field, value} -> %{field: value}
      text -> %{text: text}
    end)
  end
end
