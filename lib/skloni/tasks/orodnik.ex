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
          %{parts: [{:text, "koleg"}, {:field, "om"}]},
          {:text, " grem."}
        ])
      ),
      test(
        :ednina,
        :zenski,
        parts([
          %{parts: [{:note, "[1]"}]},
          %{parts: [{:text, "Z dobr"}, {:field, "o"}]},
          %{parts: [{:text, "prijateljic"}, {:field, "o"}]},
          {:text, " grem."}
        ])
      ),
      test(
        :ednina,
        :srednji,
        parts([
          %{parts: [{:note, "[1]"}]},
          %{parts: [{:text, "Z dobr"}, {:field, "im"}]},
          %{parts: [{:text, "dekl"}, {:field, "om"}]},
          {:text, " grem."}
        ])
      ),
      test(
        :dvojina,
        :moski,
        parts([
          %{parts: [{:note, "[2]"}]},
          %{parts: [{:text, "Z dobr"}, {:field, "ima"}]},
          %{parts: [{:text, "koleg"}, {:field, "oma"}]},
          {:text, " greva."}
        ])
      ),
      test(
        :dvojina,
        :zenski,
        parts([
          %{parts: [{:note, "[2]"}]},
          %{parts: [{:text, "Z dobr"}, {:field, "ima"}]},
          %{parts: [{:text, "prijateljic"}, {:field, "ama"}]},
          {:text, " greva."}
        ])
      ),
      test(
        :dvojina,
        :srednji,
        parts([
          %{parts: [{:note, "[2]"}]},
          %{parts: [{:text, "Z dobr"}, {:field, "ima"}]},
          %{parts: [{:text, "dekl"}, {:field, "oma"}]},
          {:text, " greva."}
        ])
      ),
      test(
        :mnozina,
        :moski,
        parts([
          %{parts: [{:note, "[3]"}]},
          %{parts: [{:text, "Z dobr"}, {:field, "imi"}]},
          %{parts: [{:text, "koleg"}, {:field, "i"}]},
          {:text, " gremo."}
        ])
      ),
      test(
        :mnozina,
        :zenski,
        parts([
          %{parts: [{:note, "[3]"}]},
          %{parts: [{:text, "Z dobr"}, {:field, "imi"}]},
          %{parts: [{:text, "prijateljic"}, {:field, "ami"}]},
          {:text, " gremo."}
        ])
      ),
      test(
        :mnozina,
        :srednji,
        parts([
          %{parts: [{:note, "[3]"}]},
          %{parts: [{:text, "Z dobr"}, {:field, "imi"}]},
          %{parts: [{:text, "dekl"}, {:field, "i"}]},
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
