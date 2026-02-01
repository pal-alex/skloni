defmodule Skloni.Tasks.Orodnik do
  @moduledoc false

  def tests do
    [
      test(
        :ednina,
        :moski,
        parts([%{text: "Z dobr", field: "im"}, %{text: "koleg", field: "om"}, " grem."])
      ),
      test(
        :ednina,
        :zenski,
        parts([%{text: "Z dobr", field: "o"}, %{text: "prijateljic", field: "o"}, " grem."])
      ),
      test(
        :ednina,
        :srednji,
        parts([%{text: "Z dobr", field: "im"}, %{text: "dekl", field: "om"}, " grem."])
      ),
      test(
        :dvojina,
        :moski,
        parts([%{text: "Z dobr", field: "ima"}, %{text: "koleg", field: "oma"}, " greva."])
      ),
      test(
        :dvojina,
        :zenski,
        parts([%{text: "Z dobr", field: "ima"}, %{text: "prijateljic", field: "ama"}, " greva."])
      ),
      test(
        :dvojina,
        :srednji,
        parts([%{text: "Z dobr", field: "ima"}, %{text: "dekl", field: "oma"}, " greva."])
      ),
      test(
        :mnozina,
        :moski,
        parts([%{text: "Z dobr", field: "imi"}, %{text: "koleg", field: "i"}, " gremo."])
      ),
      test(
        :mnozina,
        :zenski,
        parts([%{text: "Z dobr", field: "imi"}, %{text: "prijateljic", field: "ami"}, " gremo."])
      ),
      test(
        :mnozina,
        :srednji,
        parts([%{text: "Z dobr", field: "imi"}, %{text: "dekl", field: "i"}, " gremo."])
      )
    ]
  end

  defp test(number, gender, parts) do
    %{case: :orodnik, number: number, gender: gender, parts: parts}
  end

  defp parts(items), do: items
end
