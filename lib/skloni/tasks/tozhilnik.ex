defmodule Skloni.Tasks.Tozhilnik do
  @moduledoc false

  def tests do
    [
      test(
        :ednina,
        :moski,
        parts([%{text: "Vidim dobr", field: "ega"}, %{text: "koleg", field: "a"}, "."])
      ),
      test(
        :ednina,
        :zenski,
        parts([%{text: "Vidim dobr", field: "o"}, %{text: "prijateljic", field: "o"}, "."])
      ),
      test(
        :ednina,
        :srednji,
        parts([%{text: "Vidim dobr", field: "o"}, %{text: "dekl", field: "e"}, "."])
      ),
      test(
        :dvojina,
        :moski,
        parts([%{text: "Vidiva dobr", field: "a"}, %{text: "koleg", field: "a"}, "."])
      ),
      test(
        :dvojina,
        :zenski,
        parts([%{text: "Vidiva dobr", field: "i"}, %{text: "prijateljic", field: "i"}, "."])
      ),
      test(
        :dvojina,
        :srednji,
        parts([%{text: "Vidiva dobr", field: "i"}, %{text: "dekl", field: "i"}, "."])
      ),
      test(
        :mnozina,
        :moski,
        parts([%{text: "Vidimo dobr", field: "e"}, %{text: "koleg", field: "e"}, "."])
      ),
      test(
        :mnozina,
        :zenski,
        parts([%{text: "Vidimo dobr", field: "e"}, %{text: "prijateljic", field: "e"}, "."])
      ),
      test(
        :mnozina,
        :srednji,
        parts([%{text: "Vidimo dobr", field: "a"}, %{text: "dekl", field: "a"}, "."])
      )
    ]
  end

  defp test(number, gender, parts) do
    %{case: :tozhilnik, number: number, gender: gender, parts: parts}
  end

  defp parts(items), do: items
end
