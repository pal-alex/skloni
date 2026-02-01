defmodule Skloni.Tasks.Imenovalnik do
  @moduledoc false

  def tests do
    [
      test(
        :ednina,
        :moski,
        parts([
          %{parts: [{:note, "[1]"}]},
          %{parts: [{:text, "Lep"}, {:field, ""}]},
          %{parts: [{:text, "fant"}, {:field, ""}]},
          {:text, " pride."}
        ])
      ),
      test(
        :ednina,
        :zenski,
        parts([
          %{parts: [{:note, "[1]"}]},
          %{parts: [{:text, "Lep"}, {:field, "a"}]},
          %{parts: [{:text, "prijateljic"}, {:field, "a"}]},
          {:text, " pride."}
        ])
      ),
      test(
        :ednina,
        :srednji,
        parts([
          %{parts: [{:note, "[1]"}]},
          %{parts: [{:text, "Lep"}, {:field, "o"}]},
          %{parts: [{:text, "dekl"}, {:field, "e"}]},
          {:text, " pride."}
        ])
      ),
      test(
        :dvojina,
        :moski,
        parts([
          %{parts: [{:note, "[2]"}]},
          %{parts: [{:text, "Lep"}, {:field, "a"}]},
          %{parts: [{:text, "koleg"}, {:field, "a"}]},
          %{parts: [{:text, " pride"}, {:field, "ta"}]},
          {:text, "."}
        ])
      ),
      test(
        :dvojina,
        :zenski,
        parts([
          %{parts: [{:note, "[2]"}]},
          %{parts: [{:text, "Lep"}, {:field, "i"}]},
          %{parts: [{:text, "prijateljic"}, {:field, "i"}]},
          %{parts: [{:text, " pride"}, {:field, "ta"}]},
          {:text, "."}
        ])
      ),
      test(
        :dvojina,
        :srednji,
        parts([
          %{parts: [{:note, "[2]"}]},
          %{parts: [{:text, "Lep"}, {:field, "i"}]},
          %{parts: [{:text, "dekl"}, {:field, "i"}]},
          %{parts: [{:text, " pride"}, {:field, "ta"}]},
          {:text, "."}
        ])
      ),
      test(
        :mnozina,
        :moski,
        parts([
          %{parts: [{:note, "[3]"}]},
          %{parts: [{:text, "Lep"}, {:field, "i"}]},
          %{parts: [{:text, "koleg"}, {:field, "i"}]},
          %{parts: [{:text, " pride"}, {:field, "jo"}]},
          {:text, "."}
        ])
      ),
      test(
        :mnozina,
        :zenski,
        parts([
          %{parts: [{:note, "[3]"}]},
          %{parts: [{:text, "Lep"}, {:field, "e"}]},
          %{parts: [{:text, "prijateljic"}, {:field, "e"}]},
          %{parts: [{:text, " pride"}, {:field, "jo"}]},
          {:text, "."}
        ])
      ),
      test(
        :mnozina,
        :srednji,
        parts([
          %{parts: [{:note, "[3]"}]},
          %{parts: [{:text, "Lep"}, {:field, "a"}]},
          %{parts: [{:text, "dekl"}, {:field, "a"}]},
          %{parts: [{:text, " pride"}, {:field, "jo"}]},
          {:text, "."}
        ])
      )
    ]
  end

  defp test(number, gender, parts) do
    %{case: :imenovalnik, number: number, gender: gender, parts: parts}
  end

  defp parts(items), do: items
end
