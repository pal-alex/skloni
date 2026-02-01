defmodule Skloni.Tasks.Mestnik do
  @moduledoc false

  def tests do
    [
      test(
        :ednina,
        :moski,
        parts([
          %{parts: [{:text, "O dobr"}, {:field, "em"}]},
          %{parts: [{:text, "koleg"}, {:field, "u"}]},
          {:text, " govorim."}
        ])
      ),
      test(
        :ednina,
        :zenski,
        parts([
          %{parts: [{:text, "O dobr"}, {:field, "i"}]},
          %{parts: [{:text, "prijateljic"}, {:field, "i"}]},
          {:text, " govorim."}
        ])
      ),
      test(
        :ednina,
        :srednji,
        parts([
          %{parts: [{:text, "O dobr"}, {:field, "em"}]},
          %{parts: [{:text, "dekl"}, {:field, "u"}]},
          {:text, " govorim."}
        ])
      ),
      test(
        :dvojina,
        :moski,
        parts([
          %{parts: [{:text, "O dobr"}, {:field, "ih"}]},
          %{parts: [{:text, "koleg"}, {:field, "ih"}]},
          {:text, " govoriva."}
        ])
      ),
      test(
        :dvojina,
        :zenski,
        parts([
          %{parts: [{:text, "O dobr"}, {:field, "ih"}]},
          %{parts: [{:text, "prijateljic"}, {:field, "ah"}]},
          {:text, " govoriva."}
        ])
      ),
      test(
        :dvojina,
        :srednji,
        parts([
          %{parts: [{:text, "O dobr"}, {:field, "ih"}]},
          %{parts: [{:text, "dekl"}, {:field, "ih"}]},
          {:text, " govoriva."}
        ])
      ),
      test(
        :mnozina,
        :moski,
        parts([
          %{parts: [{:text, "O dobr"}, {:field, "ih"}]},
          %{parts: [{:text, "koleg"}, {:field, "ih"}]},
          {:text, " govorimo."}
        ])
      ),
      test(
        :mnozina,
        :zenski,
        parts([
          %{parts: [{:text, "O dobr"}, {:field, "ih"}]},
          %{parts: [{:text, "prijateljic"}, {:field, "ah"}]},
          {:text, " govorimo."}
        ])
      ),
      test(
        :mnozina,
        :srednji,
        parts([
          %{parts: [{:text, "O dobr"}, {:field, "ih"}]},
          %{parts: [{:text, "dekl"}, {:field, "ih"}]},
          {:text, " govorimo."}
        ])
      )
    ]
  end

  defp test(number, gender, parts) do
    %{case: :mestnik, number: number, gender: gender, parts: parts}
  end

  defp parts(items), do: items
end
