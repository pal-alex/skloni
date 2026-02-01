defmodule Skloni.Tasks.Rodilnik do
  @moduledoc false

  def tests do
    [
      test(
        :ednina,
        :moski,
        parts([%{text: "Brez dobr", field: "ega"}, %{text: "koleg", field: "a"}, " ni dneva."])
      ),
      test(
        :ednina,
        :zenski,
        parts([
          %{text: "Brez dobr", field: "e"},
          %{text: "prijateljic", field: "e"},
          " ni dneva."
        ])
      ),
      test(
        :ednina,
        :srednji,
        parts([%{text: "Brez dobr", field: "ega"}, %{text: "dekl", field: "eta"}, " ni dneva."])
      ),
      test(
        :dvojina,
        :moski,
        parts([%{text: "Brez dobr", field: "ih"}, %{text: "koleg", field: "ov"}, " ni večera."])
      ),
      test(
        :dvojina,
        :zenski,
        parts([
          %{text: "Brez dobr", field: "ih"},
          %{text: "prijateljic", field: ""},
          " ni večera."
        ])
      ),
      test(
        :dvojina,
        :srednji,
        parts([%{text: "Brez dobr", field: "ih"}, %{text: "dekl", field: ""}, " ni večera."])
      ),
      test(
        :mnozina,
        :moski,
        parts([%{text: "Brez dobr", field: "ih"}, %{text: "koleg", field: "ov"}, " ni dneva."])
      ),
      test(
        :mnozina,
        :zenski,
        parts([
          %{text: "Brez dobr", field: "ih"},
          %{text: "prijateljic", field: ""},
          " ni dneva."
        ])
      ),
      test(
        :mnozina,
        :srednji,
        parts([%{text: "Brez dobr", field: "ih"}, %{text: "dekl", field: ""}, " ni dneva."])
      )
    ]
  end

  defp test(number, gender, parts) do
    %{case: :rodilnik, number: number, gender: gender, parts: parts}
  end

  defp parts(items), do: items
end
