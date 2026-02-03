defmodule Skloni.Tasks.Rodilnik do
  @moduledoc false

  def tasks do
    [
      task(
        :ednina,
        :moski,
        parts([
          %{parts: [{:note, "[1]"}]},
          %{parts: [{:text, "Brez dobr"}, {:field, "ega"}]},
          %{parts: [{:text, "fant"}, {:field, "a"}]},
          {:text, " ni dneva."}
        ])
      ),
      task(
        :ednina,
        :zenski,
        parts([
          %{parts: [{:note, "[1]"}]},
          %{parts: [{:text, "Brez dobr"}, {:field, "e"}]},
          %{parts: [{:text, "prijatelic"}, {:field, "e"}]},
          {:text, " ni dneva."}
        ])
      ),
      task(
        :ednina,
        :srednji,
        parts([
          %{parts: [{:note, "[1]"}]},
          %{parts: [{:text, "Brez dobr"}, {:field, "ega"}]},
          %{parts: [{:text, "mest"}, {:field, "eta"}]},
          {:text, " ni dneva."}
        ])
      ),
      task(
        :dvojina,
        :moski,
        parts([
          %{parts: [{:note, "[2]"}]},
          %{parts: [{:text, "Brez dobr"}, {:field, "ih"}]},
          %{parts: [{:text, "fant"}, {:field, "ov"}]},
          {:text, " ni večera."}
        ])
      ),
      task(
        :dvojina,
        :zenski,
        parts([
          %{parts: [{:note, "[2]"}]},
          %{parts: [{:text, "Brez dobr"}, {:field, "ih"}]},
          %{parts: [{:text, "prijatelic"}, {:field, ""}]},
          {:text, " ni večera."}
        ])
      ),
      task(
        :dvojina,
        :srednji,
        parts([
          %{parts: [{:note, "[2]"}]},
          %{parts: [{:text, "Brez dobr"}, {:field, "ih"}]},
          %{parts: [{:text, "mest"}, {:field, ""}]},
          {:text, " ni večera."}
        ])
      ),
      task(
        :mnozina,
        :moski,
        parts([
          %{parts: [{:note, "[3]"}]},
          %{parts: [{:text, "Brez dobr"}, {:field, "ih"}]},
          %{parts: [{:text, "fant"}, {:field, "ov"}]},
          {:text, " ni dneva."}
        ])
      ),
      task(
        :mnozina,
        :zenski,
        parts([
          %{parts: [{:note, "[3]"}]},
          %{parts: [{:text, "Brez dobr"}, {:field, "ih"}]},
          %{parts: [{:text, "prijatelic"}, {:field, ""}]},
          {:text, " ni dneva."}
        ])
      ),
      task(
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

  defp task(number, gender, parts) do
    %{case: :rodilnik, number: number, gender: gender, parts: parts}
  end

  defp parts(items), do: items
end
