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
          %{parts: [{:text, "koleg"}, {:field, "a"}]},
          {:text, "."}
        ])
      ),
      test(
        :ednina,
        :zenski,
        parts([
          %{parts: [{:note, "[1]"}]},
          %{parts: [{:text, "Vidim dobr"}, {:field, "o"}]},
          %{parts: [{:text, "prijateljic"}, {:field, "o"}]},
          {:text, "."}
        ])
      ),
      test(
        :ednina,
        :srednji,
        parts([
          %{parts: [{:note, "[1]"}]},
          %{parts: [{:text, "Vidim dobr"}, {:field, "o"}]},
          %{parts: [{:text, "dekl"}, {:field, "e"}]},
          {:text, "."}
        ])
      ),
      test(
        :dvojina,
        :moski,
        parts([
          %{parts: [{:note, "[2]"}]},
          %{parts: [{:text, "Vidiva dobr"}, {:field, "a"}]},
          %{parts: [{:text, "koleg"}, {:field, "a"}]},
          {:text, "."}
        ])
      ),
      test(
        :dvojina,
        :zenski,
        parts([
          %{parts: [{:note, "[2]"}]},
          %{parts: [{:text, "Vidiva dobr"}, {:field, "i"}]},
          %{parts: [{:text, "prijateljic"}, {:field, "i"}]},
          {:text, "."}
        ])
      ),
      test(
        :dvojina,
        :srednji,
        parts([
          %{parts: [{:note, "[2]"}]},
          %{parts: [{:text, "Vidiva dobr"}, {:field, "i"}]},
          %{parts: [{:text, "dekl"}, {:field, "i"}]},
          {:text, "."}
        ])
      ),
      test(
        :mnozina,
        :moski,
        parts([
          %{parts: [{:note, "[3]"}]},
          %{parts: [{:text, "Vidimo dobr"}, {:field, "e"}]},
          %{parts: [{:text, "koleg"}, {:field, "e"}]},
          {:text, "."}
        ])
      ),
      test(
        :mnozina,
        :zenski,
        parts([
          %{parts: [{:note, "[3]"}]},
          %{parts: [{:text, "Vidimo dobr"}, {:field, "e"}]},
          %{parts: [{:text, "prijateljic"}, {:field, "e"}]},
          {:text, "."}
        ])
      ),
      test(
        :mnozina,
        :srednji,
        parts([
          %{parts: [{:note, "[3]"}]},
          %{parts: [{:text, "Vidimo dobr"}, {:field, "a"}]},
          %{parts: [{:text, "dekl"}, {:field, "a"}]},
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
