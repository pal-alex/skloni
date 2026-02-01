defmodule Skloni.Tasks.Tozhilnik do
  @moduledoc false

  def tests do
    [
      test(
        :ednina,
        :moski,
        parts([
          %{parts: [{:note, "[1]"}]},
          %{parts: [{:text, "Vidim dobr"}, {:field, "ega"}]},
          %{parts: [{:text, "fant"}, {:field, "a"}]},
          {:text, "."}
        ])
      ),
      test(
        :ednina,
        :zenski,
        parts([
          %{parts: [{:note, "[1]"}]},
          %{parts: [{:text, "Vidim dobr"}, {:field, "o"}]},
          %{parts: [{:text, "prijatelic"}, {:field, "o"}]},
          {:text, "."}
        ])
      ),
      test(
        :ednina,
        :srednji,
        parts([
          %{parts: [{:note, "[1]"}]},
          %{parts: [{:text, "Vidim dobr"}, {:field, "o"}]},
          %{parts: [{:text, "mest"}, {:field, "o"}]},
          {:text, "."}
        ])
      ),
      test(
        :dvojina,
        :moski,
        parts([
          %{parts: [{:note, "[2]"}]},
          %{parts: [{:text, "Vidiva dobr"}, {:field, "a"}]},
          %{parts: [{:text, "fant"}, {:field, "a"}]},
          {:text, "."}
        ])
      ),
      test(
        :dvojina,
        :zenski,
        parts([
          %{parts: [{:note, "[2]"}]},
          %{parts: [{:text, "Vidiva dobr"}, {:field, "i"}]},
          %{parts: [{:text, "prijatelic"}, {:field, "i"}]},
          {:text, "."}
        ])
      ),
      test(
        :dvojina,
        :srednji,
        parts([
          %{parts: [{:note, "[2]"}]},
          %{parts: [{:text, "Vidiva dobr"}, {:field, "i"}]},
          %{parts: [{:text, "mest"}, {:field, "i"}]},
          {:text, "."}
        ])
      ),
      test(
        :mnozina,
        :moski,
        parts([
          %{parts: [{:note, "[3]"}]},
          %{parts: [{:text, "Vidimo dobr"}, {:field, "e"}]},
          %{parts: [{:text, "fant"}, {:field, "e"}]},
          {:text, "."}
        ])
      ),
      test(
        :mnozina,
        :zenski,
        parts([
          %{parts: [{:note, "[3]"}]},
          %{parts: [{:text, "Vidimo dobr"}, {:field, "e"}]},
          %{parts: [{:text, "prijatelic"}, {:field, "e"}]},
          {:text, "."}
        ])
      ),
      test(
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

  defp test(number, gender, parts) do
    %{case: :tozhilnik, number: number, gender: gender, parts: parts}
  end

  defp parts(items), do: items
end
