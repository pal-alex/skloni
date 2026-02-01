defmodule Skloni.Tasks.Mestnik do
  @moduledoc false

  def tests do
    [
      test(
        :ednina,
        :moski,
        parts([%{text: "O dobr", field: "em"}, %{text: "koleg", field: "u"}, " govorim."])
      ),
      test(
        :ednina,
        :zenski,
        parts([%{text: "O dobr", field: "i"}, %{text: "prijateljic", field: "i"}, " govorim."])
      ),
      test(
        :ednina,
        :srednji,
        parts([%{text: "O dobr", field: "em"}, %{text: "dekl", field: "u"}, " govorim."])
      ),
      test(
        :dvojina,
        :moski,
        parts([%{text: "O dobr", field: "ih"}, %{text: "koleg", field: "ih"}, " govoriva."])
      ),
      test(
        :dvojina,
        :zenski,
        parts([%{text: "O dobr", field: "ih"}, %{text: "prijateljic", field: "ah"}, " govoriva."])
      ),
      test(
        :dvojina,
        :srednji,
        parts([%{text: "O dobr", field: "ih"}, %{text: "dekl", field: "ih"}, " govoriva."])
      ),
      test(
        :mnozina,
        :moski,
        parts([%{text: "O dobr", field: "ih"}, %{text: "koleg", field: "ih"}, " govorimo."])
      ),
      test(
        :mnozina,
        :zenski,
        parts([%{text: "O dobr", field: "ih"}, %{text: "prijateljic", field: "ah"}, " govorimo."])
      ),
      test(
        :mnozina,
        :srednji,
        parts([%{text: "O dobr", field: "ih"}, %{text: "dekl", field: "ih"}, " govorimo."])
      )
    ]
  end

  defp test(number, gender, parts) do
    %{case: :mestnik, number: number, gender: gender, parts: parts}
  end

  defp parts(items), do: items
end
