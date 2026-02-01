defmodule Skloni.Tasks.Dajalnik do
  @moduledoc false

  def tests do
    [
      test(
        :ednina,
        :moski,
        parts([
          %{parts: [{:note, "[1]"}]},
          %{parts: [{:text, "K dobr"}, {:field, "emu"}]},
          %{parts: [{:text, "koleg"}, {:field, "u"}]},
          {:text, " grem."}
        ])
      ),
      test(
        :ednina,
        :zenski,
        parts([
          %{parts: [{:note, "[1]"}]},
          %{parts: [{:text, "K dobr"}, {:field, "i"}]},
          %{parts: [{:text, "prijateljic"}, {:field, "i"}]},
          {:text, " grem."}
        ])
      ),
      test(
        :ednina,
        :srednji,
        parts([
          %{parts: [{:note, "[1]"}]},
          %{parts: [{:text, "K dobr"}, {:field, "emu"}]},
          %{parts: [{:text, "dekl"}, {:field, "u"}]},
          {:text, " grem."}
        ])
      ),
      test(
        :dvojina,
        :moski,
        parts([
          %{parts: [{:note, "[2]"}]},
          %{parts: [{:text, "K dobr"}, {:field, "ima"}]},
          %{parts: [{:text, "koleg"}, {:field, "oma"}]},
          {:text, " greva."}
        ])
      ),
      test(
        :dvojina,
        :zenski,
        parts([
          %{parts: [{:note, "[2]"}]},
          %{parts: [{:text, "K dobr"}, {:field, "ima"}]},
          %{parts: [{:text, "prijateljic"}, {:field, "ama"}]},
          {:text, " greva."}
        ])
      ),
      test(
        :dvojina,
        :srednji,
        parts([
          %{parts: [{:note, "[2]"}]},
          %{parts: [{:text, "K dobr"}, {:field, "ima"}]},
          %{parts: [{:text, "dekl"}, {:field, "oma"}]},
          {:text, " greva."}
        ])
      ),
      test(
        :mnozina,
        :moski,
        parts([
          %{parts: [{:note, "[3]"}]},
          %{parts: [{:text, "K dobr"}, {:field, "im"}]},
          %{parts: [{:text, "koleg"}, {:field, "om"}]},
          {:text, " gremo."}
        ])
      ),
      test(
        :mnozina,
        :zenski,
        parts([
          %{parts: [{:note, "[3]"}]},
          %{parts: [{:text, "K dobr"}, {:field, "im"}]},
          %{parts: [{:text, "prijateljic"}, {:field, "am"}]},
          {:text, " gremo."}
        ])
      ),
      test(
        :mnozina,
        :srednji,
        parts([
          %{parts: [{:note, "[3]"}]},
          %{parts: [{:text, "K dobr"}, {:field, "im"}]},
          %{parts: [{:text, "dekl"}, {:field, "om"}]},
          {:text, " gremo."}
        ])
      )
    ]
  end

  defp test(number, gender, parts) do
    %{case: :dajalnik, number: number, gender: gender, parts: parts}
  end

  defp parts(items), do: items
end
