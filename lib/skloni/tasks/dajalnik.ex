defmodule Skloni.Tasks.Dajalnik do
  @moduledoc false

  def tests do
    [
      test(
        :ednina,
        :moski,
        parts([%{text: "K dobr", field: "emu"}, %{text: "koleg", field: "u"}, " grem."])
      ),
      test(
        :ednina,
        :zenski,
        parts([%{text: "K dobr", field: "i"}, %{text: "prijateljic", field: "i"}, " grem."])
      ),
      test(
        :ednina,
        :srednji,
        parts([%{text: "K dobr", field: "emu"}, %{text: "dekl", field: "u"}, " grem."])
      ),
      test(
        :dvojina,
        :moski,
        parts([%{text: "K dobr", field: "ima"}, %{text: "koleg", field: "oma"}, " greva."])
      ),
      test(
        :dvojina,
        :zenski,
        parts([%{text: "K dobr", field: "ima"}, %{text: "prijateljic", field: "ama"}, " greva."])
      ),
      test(
        :dvojina,
        :srednji,
        parts([%{text: "K dobr", field: "ima"}, %{text: "dekl", field: "oma"}, " greva."])
      ),
      test(
        :mnozina,
        :moski,
        parts([%{text: "K dobr", field: "im"}, %{text: "koleg", field: "om"}, " gremo."])
      ),
      test(
        :mnozina,
        :zenski,
        parts([%{text: "K dobr", field: "im"}, %{text: "prijateljic", field: "am"}, " gremo."])
      ),
      test(
        :mnozina,
        :srednji,
        parts([%{text: "K dobr", field: "im"}, %{text: "dekl", field: "om"}, " gremo."])
      )
    ]
  end

  defp test(number, gender, parts) do
    %{case: :dajalnik, number: number, gender: gender, parts: parts}
  end

  defp parts(items), do: items
end
