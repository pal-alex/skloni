defmodule Skloni.Tasks.Mestnik do
  @moduledoc false

  def tests do
    [
      test(
        :ednina,
        :moski,
        parts(["O dobr", {:field, "em"}, " koleg", {:field, "u"}, " govorim."])
      ),
      test(
        :ednina,
        :zenski,
        parts(["O dobr", {:field, "i"}, " prijateljic", {:field, "i"}, " govorim."])
      ),
      test(
        :ednina,
        :srednji,
        parts(["O dobr", {:field, "em"}, " dekl", {:field, "u"}, " govorim."])
      ),
      test(
        :dvojina,
        :moski,
        parts(["O dobr", {:field, "ih"}, " koleg", {:field, "ih"}, " govoriva."])
      ),
      test(
        :dvojina,
        :zenski,
        parts(["O dobr", {:field, "ih"}, " prijateljic", {:field, "ah"}, " govoriva."])
      ),
      test(
        :dvojina,
        :srednji,
        parts(["O dobr", {:field, "ih"}, " dekl", {:field, "ih"}, " govoriva."])
      ),
      test(
        :mnozina,
        :moski,
        parts(["O dobr", {:field, "ih"}, " koleg", {:field, "ih"}, " govorimo."])
      ),
      test(
        :mnozina,
        :zenski,
        parts(["O dobr", {:field, "ih"}, " prijateljic", {:field, "ah"}, " govorimo."])
      ),
      test(
        :mnozina,
        :srednji,
        parts(["O dobr", {:field, "ih"}, " dekl", {:field, "ih"}, " govorimo."])
      )
    ]
  end

  defp test(number, gender, parts) do
    %{case: :mestnik, number: number, gender: gender, parts: parts}
  end

  defp parts(items) do
    Enum.map(items, fn
      {:field, value} -> %{field: value}
      text -> %{text: text}
    end)
  end
end
