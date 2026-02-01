defmodule Skloni.Tasks.Imenovalnik do
  @moduledoc false

  def tests do
    [
      test(
        :ednina,
        :moski,
        parts([%{text: "Lep", field: "i"}, %{text: "koleg", field: "a"}, " pride."])
      ),
      test(
        :ednina,
        :zenski,
        parts([%{text: "Lep", field: "a"}, %{text: "prijateljic", field: "a"}, " pride."])
      ),
      test(
        :ednina,
        :srednji,
        parts([%{text: "Lep", field: "o"}, %{text: "dekl", field: "e"}, " pride."])
      ),
      test(
        :dvojina,
        :moski,
        parts([
          %{text: "Lep", field: "a"},
          %{text: "koleg", field: "a"},
          %{text: " pride", field: "ta"},
          "."
        ])
      ),
      test(
        :dvojina,
        :zenski,
        parts([
          %{text: "Lep", field: "i"},
          %{text: "prijateljic", field: "i"},
          %{text: " pride", field: "ta"},
          "."
        ])
      ),
      test(
        :dvojina,
        :srednji,
        parts([
          %{text: "Lep", field: "i"},
          %{text: "dekl", field: "i"},
          %{text: " pride", field: "ta"},
          "."
        ])
      ),
      test(
        :mnozina,
        :moski,
        parts([
          %{text: "Lep", field: "i"},
          %{text: "koleg", field: "i"},
          %{text: " pride", field: "jo"},
          "."
        ])
      ),
      test(
        :mnozina,
        :zenski,
        parts([
          %{text: "Lep", field: "e"},
          %{text: "prijateljic", field: "e"},
          %{text: " pride", field: "jo"},
          "."
        ])
      ),
      test(
        :mnozina,
        :srednji,
        parts([
          %{text: "Lep", field: "a"},
          %{text: "dekl", field: "a"},
          %{text: " pride", field: "jo"},
          "."
        ])
      )
    ]
  end

  defp test(number, gender, parts) do
    %{case: :imenovalnik, number: number, gender: gender, parts: parts}
  end

  defp parts(items), do: items
end
