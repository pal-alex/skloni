defmodule Skloni.Tasks.Imenovalnik do
  @moduledoc false

  def tasks do
    [
      task(
        :ednina,
        :moski,
        parts([
          %{parts: [{:note, "[1]"}]},
          %{parts: [{:text, "Lep"}, {:field, ""}]},
          %{parts: [{:text, "fant"}, {:field, ""}]},
          %{parts: [{:text, " pride"}, {:field, ""}]},
          {:text, "."}
        ])
      ),
      task(
        :ednina,
        :zenski,
        parts([
          %{parts: [{:note, "[1]"}]},
          %{parts: [{:text, "Lep"}, {:field, "a"}]},
          %{parts: [{:text, "prijatelic"}, {:field, "a"}]},
          %{parts: [{:text, " pride"}, {:field, ""}]},
          {:text, "."}
        ])
      ),
      task(
        :ednina,
        :srednji,
        parts([
          %{parts: [{:note, "[1]"}]},
          %{parts: [{:text, "Lep"}, {:field, "o"}]},
          %{parts: [{:text, "mest"}, {:field, "o"}]},
          {:text, "imaš."}
        ])
      ),
      task(
        :dvojina,
        :moski,
        parts([
          %{parts: [{:note, "[2]"}]},
          %{parts: [{:text, "Lep"}, {:field, "a"}]},
          %{parts: [{:text, "fant"}, {:field, "a"}]},
          %{parts: [{:text, " pride"}, {:field, "ta"}]},
          {:text, "."}
        ])
      ),
      task(
        :dvojina,
        :zenski,
        parts([
          %{parts: [{:note, "[2]"}]},
          %{parts: [{:text, "Lep"}, {:field, "i"}]},
          %{parts: [{:text, "prijatelic"}, {:field, "i"}]},
          %{parts: [{:text, " pride"}, {:field, "ta"}]},
          {:text, "."}
        ])
      ),
      task(
        :dvojina,
        :srednji,
        parts([
          %{parts: [{:note, "[2]"}]},
          %{parts: [{:text, "Lep"}, {:field, "i"}]},
          %{parts: [{:text, "mest"}, {:field, "i"}]},
          %{parts: [{:text, " pride"}, {:field, "ta"}]},
          {:text, "."}
        ])
      ),
      task(
        :mnozina,
        :moski,
        parts([
          %{parts: [{:note, "[3]"}]},
          %{parts: [{:text, "Lep"}, {:field, "i"}]},
          %{parts: [{:text, "fant"}, {:field, "i"}]},
          %{parts: [{:text, " pride"}, {:field, "jo"}]},
          {:text, "."}
        ])
      ),
      task(
        :mnozina,
        :zenski,
        parts([
          %{parts: [{:note, "[3]"}]},
          %{parts: [{:text, "Lep"}, {:field, "e"}]},
          %{parts: [{:text, "prijatelic"}, {:field, "e"}]},
          %{parts: [{:text, " pride"}, {:field, "jo"}]},
          {:text, "."}
        ])
      ),
      task(
        :mnozina,
        :srednji,
        parts([
          %{parts: [{:note, "[3]"}]},
          %{parts: [{:text, "Lep"}, {:field, "a"}]},
          %{parts: [{:text, "mest"}, {:field, "a"}]},
          %{parts: [{:text, " pride"}, {:field, "jo"}]},
          {:text, "."}
        ])
      )
    ]
  end

  defp task(number, gender, parts) do
    %{case: :imenovalnik, number: number, gender: gender, parts: parts}
  end

  defp parts(items), do: items
end
