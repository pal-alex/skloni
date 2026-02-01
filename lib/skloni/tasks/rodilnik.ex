defmodule Skloni.Tasks.Rodilnik do
  @moduledoc false

  def tests do
    [
      test(
        :ednina,
        :moski,
        parts([
          %{parts: [{:text, "Brez dobr"}, {:field, "ega"}]},
          %{parts: [{:text, "koleg"}, {:field, "a"}]},
          {:text, " ni dneva."}
        ])
      ),
      test(
        :ednina,
        :zenski,
        parts([
          %{parts: [{:text, "Brez dobr"}, {:field, "e"}]},
          %{parts: [{:text, "prijateljic"}, {:field, "e"}]},
          {:text, " ni dneva."}
        ])
      ),
      test(
        :ednina,
        :srednji,
        parts([
          %{parts: [{:text, "Brez dobr"}, {:field, "ega"}]},
          %{parts: [{:text, "dekl"}, {:field, "eta"}]},
          {:text, " ni dneva."}
        ])
      ),
      test(
        :dvojina,
        :moski,
        parts([
          %{parts: [{:text, "Brez dobr"}, {:field, "ih"}]},
          %{parts: [{:text, "koleg"}, {:field, "ov"}]},
          {:text, " ni večera."}
        ])
      ),
      test(
        :dvojina,
        :zenski,
        parts([
          %{parts: [{:text, "Brez dobr"}, {:field, "ih"}]},
          %{parts: [{:text, "prijateljic"}, {:field, ""}]},
          {:text, " ni večera."}
        ])
      ),
      test(
        :dvojina,
        :srednji,
        parts([
          %{parts: [{:text, "Brez dobr"}, {:field, "ih"}]},
          %{parts: [{:text, "dekl"}, {:field, ""}]},
          {:text, " ni večera."}
        ])
      ),
      test(
        :mnozina,
        :moski,
        parts([
          %{parts: [{:text, "Brez dobr"}, {:field, "ih"}]},
          %{parts: [{:text, "koleg"}, {:field, "ov"}]},
          {:text, " ni dneva."}
        ])
      ),
      test(
        :mnozina,
        :zenski,
        parts([
          %{parts: [{:text, "Brez dobr"}, {:field, "ih"}]},
          %{parts: [{:text, "prijateljic"}, {:field, ""}]},
          {:text, " ni dneva."}
        ])
      ),
      test(
        :mnozina,
        :srednji,
        parts([
          %{parts: [{:text, "Brez dobr"}, {:field, "ih"}]},
          %{parts: [{:text, "dekl"}, {:field, ""}]},
          {:text, " ni dneva."}
        ])
      )
    ]
  end

  defp test(number, gender, parts) do
    %{case: :rodilnik, number: number, gender: gender, parts: parts}
  end

  defp parts(items), do: items
end
