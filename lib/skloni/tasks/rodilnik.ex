defmodule Skloni.Tasks.Rodilnik do
  @moduledoc false

  def tests do
    [
      test(
        :ednina,
        :moski,
        parts([
          %{parts: [{:note, "[1]"}]},
          %{parts: [{:text, "Brez dobr"}, {:field, "ega"}]},
          %{parts: [{:text, "fant"}, {:field, "a"}]},
          {:text, " ni dneva."}
        ])
      ),
      test(
        :ednina,
        :zenski,
        parts([
          %{parts: [{:note, "[1]"}]},
          %{parts: [{:text, "Brez dobr"}, {:field, "e"}]},
          %{parts: [{:text, "prijatelic"}, {:field, "e"}]},
          {:text, " ni dneva."}
        ])
      ),
      test(
        :ednina,
        :srednji,
        parts([
          %{parts: [{:note, "[1]"}]},
          %{parts: [{:text, "Brez dobr"}, {:field, "ega"}]},
          %{parts: [{:text, "mest"}, {:field, "eta"}]},
          {:text, " ni dneva."}
        ])
      ),
      test(
        :dvojina,
        :moski,
        parts([
          %{parts: [{:note, "[2]"}]},
          %{parts: [{:text, "Brez dobr"}, {:field, "ih"}]},
          %{parts: [{:text, "fant"}, {:field, "ov"}]},
          {:text, " ni večera."}
        ])
      ),
      test(
        :dvojina,
        :zenski,
        parts([
          %{parts: [{:note, "[2]"}]},
          %{parts: [{:text, "Brez dobr"}, {:field, "ih"}]},
          %{parts: [{:text, "prijatelic"}, {:field, ""}]},
          {:text, " ni večera."}
        ])
      ),
      test(
        :dvojina,
        :srednji,
        parts([
          %{parts: [{:note, "[2]"}]},
          %{parts: [{:text, "Brez dobr"}, {:field, "ih"}]},
          %{parts: [{:text, "mest"}, {:field, ""}]},
          {:text, " ni večera."}
        ])
      ),
      test(
        :mnozina,
        :moski,
        parts([
          %{parts: [{:note, "[3]"}]},
          %{parts: [{:text, "Brez dobr"}, {:field, "ih"}]},
          %{parts: [{:text, "fant"}, {:field, "ov"}]},
          {:text, " ni dneva."}
        ])
      ),
      test(
        :mnozina,
        :zenski,
        parts([
          %{parts: [{:note, "[3]"}]},
          %{parts: [{:text, "Brez dobr"}, {:field, "ih"}]},
          %{parts: [{:text, "prijatelic"}, {:field, ""}]},
          {:text, " ni dneva."}
        ])
      ),
      test(
        :mnozina,
        :srednji,
        parts([
          %{parts: [{:note, "[3]"}]},
          %{parts: [{:text, "Brez dobr"}, {:field, "ih"}]},
          %{parts: [{:text, "mest"}, {:field, ""}]},
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
