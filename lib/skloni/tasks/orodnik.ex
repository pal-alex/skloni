defmodule Skloni.Tasks.Orodnik do
  @moduledoc false

  def tasks do
    [
      task(
        :ednina,
        :moski,
        parts([
          %{parts: [{:note, "[1]"}]},
          %{parts: [{:text, "Z dobr"}, {:field, "im"}]},
          %{parts: [{:text, "fant"}, {:field, "om"}]},
          {:text, " grem."}
        ])
      ),
      task(
        :ednina,
        :zenski,
        parts([
          %{parts: [{:note, "[1]"}]},
          %{parts: [{:text, "Z dobr"}, {:field, "o"}]},
          %{parts: [{:text, "prijatelic"}, {:field, "o"}]},
          {:text, " grem."}
        ])
      ),
      task(
        :ednina,
        :srednji,
        parts([
          %{parts: [{:note, "[1]"}]},
          %{parts: [{:text, "Z dobr"}, {:field, "im"}]},
          %{parts: [{:text, "mest"}, {:field, "om"}]},
          {:text, " grem."}
        ])
      ),
      task(
        :dvojina,
        :moski,
        parts([
          %{parts: [{:note, "[2]"}]},
          %{parts: [{:text, "Z dobr"}, {:field, "ima"}]},
          %{parts: [{:text, "fant"}, {:field, "oma"}]},
          {:text, " greva."}
        ])
      ),
      task(
        :dvojina,
        :zenski,
        parts([
          %{parts: [{:note, "[2]"}]},
          %{parts: [{:text, "Z dobr"}, {:field, "ima"}]},
          %{parts: [{:text, "prijatelic"}, {:field, "ama"}]},
          {:text, " greva."}
        ])
      ),
      task(
        :dvojina,
        :srednji,
        parts([
          %{parts: [{:note, "[2]"}]},
          %{parts: [{:text, "Z dobr"}, {:field, "ima"}]},
          %{parts: [{:text, "mest"}, {:field, "oma"}]},
          {:text, " greva."}
        ])
      ),
      task(
        :mnozina,
        :moski,
        parts([
          %{parts: [{:note, "[3]"}]},
          %{parts: [{:text, "Z dobr"}, {:field, "imi"}]},
          %{parts: [{:text, "fant"}, {:field, "i"}]},
          {:text, " gremo."}
        ])
      ),
      task(
        :mnozina,
        :zenski,
        parts([
          %{parts: [{:note, "[3]"}]},
          %{parts: [{:text, "Z dobr"}, {:field, "imi"}]},
          %{parts: [{:text, "prijatelic"}, {:field, "ami"}]},
          {:text, " gremo."}
        ])
      ),
      task(
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

  defp task(number, gender, parts) do
    %{case: :orodnik, number: number, gender: gender, parts: parts}
  end

  defp parts(items), do: items
end
