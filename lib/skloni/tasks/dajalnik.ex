defmodule Skloni.Tasks.Dajalnik do
  @moduledoc false

  def tasks do
    [
      task(
        :ednina,
        :moski,
        parts([
          %{parts: [{:note, "[1]"}]},
          %{parts: [{:text, "K dobr"}, {:field, "emu"}]},
          %{parts: [{:text, "fant"}, {:field, "u"}]},
          {:text, " grem."}
        ])
      ),
      task(
        :ednina,
        :zenski,
        parts([
          %{parts: [{:note, "[1]"}]},
          %{parts: [{:text, "K dobr"}, {:field, "i"}]},
          %{parts: [{:text, "prijatelic"}, {:field, "i"}]},
          {:text, " grem."}
        ])
      ),
      task(
        :ednina,
        :srednji,
        parts([
          %{parts: [{:note, "[1]"}]},
          %{parts: [{:text, "K dobr"}, {:field, "emu"}]},
          %{parts: [{:text, "mest"}, {:field, "u"}]},
          {:text, " grem."}
        ])
      ),
      task(
        :dvojina,
        :moski,
        parts([
          %{parts: [{:note, "[2]"}]},
          %{parts: [{:text, "K dobr"}, {:field, "ima"}]},
          %{parts: [{:text, "fant"}, {:field, "oma"}]},
          {:text, " greva."}
        ])
      ),
      task(
        :dvojina,
        :zenski,
        parts([
          %{parts: [{:note, "[2]"}]},
          %{parts: [{:text, "K dobr"}, {:field, "ima"}]},
          %{parts: [{:text, "prijatelic"}, {:field, "ama"}]},
          {:text, " greva."}
        ])
      ),
      task(
        :dvojina,
        :srednji,
        parts([
          %{parts: [{:note, "[2]"}]},
          %{parts: [{:text, "K dobr"}, {:field, "ima"}]},
          %{parts: [{:text, "mest"}, {:field, "oma"}]},
          {:text, " greva."}
        ])
      ),
      task(
        :mnozina,
        :moski,
        parts([
          %{parts: [{:note, "[3]"}]},
          %{parts: [{:text, "K dobr"}, {:field, "im"}]},
          %{parts: [{:text, "fant"}, {:field, "om"}]},
          {:text, " gremo."}
        ])
      ),
      task(
        :mnozina,
        :zenski,
        parts([
          %{parts: [{:note, "[3]"}]},
          %{parts: [{:text, "K dobr"}, {:field, "im"}]},
          %{parts: [{:text, "prijatelic"}, {:field, "am"}]},
          {:text, " gremo."}
        ])
      ),
      task(
        :mnozina,
        :srednji,
        parts([
          %{parts: [{:note, "[3]"}]},
          %{parts: [{:text, "K dobr"}, {:field, "im"}]},
          %{parts: [{:text, "mest"}, {:field, "om"}]},
          {:text, " gremo."}
        ])
      )
    ]
  end

  defp task(number, gender, parts) do
    %{case: :dajalnik, number: number, gender: gender, parts: parts}
  end

  defp parts(items), do: items
end
