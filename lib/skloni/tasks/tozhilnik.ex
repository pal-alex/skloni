defmodule Skloni.Tasks.Tozhilnik do
  @moduledoc false

  def tasks do
    [
      task(
        :ednina,
        :moski,
        parts([
          %{parts: [{:note, "[1]"}]},
          %{parts: [{:text, "Vidim dobr"}, {:field, "ega"}]},
          %{parts: [{:text, "fant"}, {:field, "a"}]},
          {:text, "."}
        ])
      ),
      task(
        :ednina,
        :zenski,
        parts([
          %{parts: [{:note, "[1]"}]},
          %{parts: [{:text, "Vidim dobr"}, {:field, "o"}]},
          %{parts: [{:text, "prijatelic"}, {:field, "o"}]},
          {:text, "."}
        ])
      ),
      task(
        :ednina,
        :srednji,
        parts([
          %{parts: [{:note, "[1]"}]},
          %{parts: [{:text, "Vidim dobr"}, {:field, "o"}]},
          %{parts: [{:text, "mest"}, {:field, "o"}]},
          {:text, "."}
        ])
      ),
      task(
        :dvojina,
        :moski,
        parts([
          %{parts: [{:note, "[2]"}]},
          %{parts: [{:text, "Vidiva dobr"}, {:field, "a"}]},
          %{parts: [{:text, "fant"}, {:field, "a"}]},
          {:text, "."}
        ])
      ),
      task(
        :dvojina,
        :zenski,
        parts([
          %{parts: [{:note, "[2]"}]},
          %{parts: [{:text, "Vidiva dobr"}, {:field, "i"}]},
          %{parts: [{:text, "prijatelic"}, {:field, "i"}]},
          {:text, "."}
        ])
      ),
      task(
        :dvojina,
        :srednji,
        parts([
          %{parts: [{:note, "[2]"}]},
          %{parts: [{:text, "Vidiva dobr"}, {:field, "i"}]},
          %{parts: [{:text, "mest"}, {:field, "i"}]},
          {:text, "."}
        ])
      ),
      task(
        :mnozina,
        :moski,
        parts([
          %{parts: [{:note, "[3]"}]},
          %{parts: [{:text, "Vidimo dobr"}, {:field, "e"}]},
          %{parts: [{:text, "fant"}, {:field, "e"}]},
          {:text, "."}
        ])
      ),
      task(
        :mnozina,
        :zenski,
        parts([
          %{parts: [{:note, "[3]"}]},
          %{parts: [{:text, "Vidimo dobr"}, {:field, "e"}]},
          %{parts: [{:text, "prijatelic"}, {:field, "e"}]},
          {:text, "."}
        ])
      ),
      task(
        :mnozina,
        :srednji,
        parts([
          %{parts: [{:note, "[3]"}]},
          %{parts: [{:text, "Vidimo dobr"}, {:field, "a"}]},
          %{parts: [{:text, "mest"}, {:field, "a"}]},
          {:text, "."}
        ])
      )
    ]
  end

  defp task(number, gender, parts) do
    %{case: :tozhilnik, number: number, gender: gender, parts: parts}
  end

  defp parts(items), do: items
end
