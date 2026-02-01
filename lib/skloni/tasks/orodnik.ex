defmodule Skloni.Tasks.Orodnik do
  @moduledoc false

  def tests do
    [
      test(
        :ednina,
        :moski,
        parts([
          %{parts: [{:note, "[1]"}]},
          %{parts: [{:text, "Z dobr"}, {:field, "im"}]},
          %{parts: [{:text, "fant"}, {:field, "om"}]},
          {:text, " grem."}
        ])
      ),
      test(
        :ednina,
        :zenski,
        parts([
          %{parts: [{:note, "[1]"}]},
          %{parts: [{:text, "Z dobr"}, {:field, "o"}]},
          %{parts: [{:text, "prijatelic"}, {:field, "o"}]},
          {:text, " grem."}
        ])
      ),
      test(
        :ednina,
        :srednji,
        parts([
          %{parts: [{:note, "[1]"}]},
          %{parts: [{:text, "Z dobr"}, {:field, "im"}]},
          %{parts: [{:text, "mest"}, {:field, "om"}]},
          {:text, " grem."}
        ])
      ),
      test(
        :dvojina,
        :moski,
        parts([
          %{parts: [{:note, "[2]"}]},
          %{parts: [{:text, "Z dobr"}, {:field, "ima"}]},
          %{parts: [{:text, "fant"}, {:field, "oma"}]},
          {:text, " greva."}
        ])
      ),
      test(
        :dvojina,
        :zenski,
        parts([
          %{parts: [{:note, "[2]"}]},
          %{parts: [{:text, "Z dobr"}, {:field, "ima"}]},
          %{parts: [{:text, "prijatelic"}, {:field, "ama"}]},
          {:text, " greva."}
        ])
      ),
      test(
        :dvojina,
        :srednji,
        parts([
          %{parts: [{:note, "[2]"}]},
          %{parts: [{:text, "Z dobr"}, {:field, "ima"}]},
          %{parts: [{:text, "mest"}, {:field, "oma"}]},
          {:text, " greva."}
        ])
      ),
      test(
        :mnozina,
        :moski,
        parts([
          %{parts: [{:note, "[3]"}]},
          %{parts: [{:text, "Z dobr"}, {:field, "imi"}]},
          %{parts: [{:text, "fant"}, {:field, "i"}]},
          {:text, " gremo."}
        ])
      ),
      test(
        :mnozina,
        :zenski,
        parts([
          %{parts: [{:note, "[3]"}]},
          %{parts: [{:text, "Z dobr"}, {:field, "imi"}]},
          %{parts: [{:text, "prijatelic"}, {:field, "ami"}]},
          {:text, " gremo."}
        ])
      ),
      test(
        :mnozina,
        :srednji,
        parts([
          %{parts: [{:note, "[3]"}]},
          %{parts: [{:text, "Z dobr"}, {:field, "imi"}]},
          %{parts: [{:text, "mest"}, {:field, "i"}]},
          {:text, " gremo."}
        ])
      )
    ]
  end

  defp test(number, gender, parts) do
    %{case: :orodnik, number: number, gender: gender, parts: parts}
  end

  defp parts(items), do: items
end
