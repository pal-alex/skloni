defmodule Skloni.Tasks.Rodilnik do
  @moduledoc false

  def tests do
    [
      test(
        :ednina,
        :moski,
        parts(["Brez dobr", {:field, "ega"}, " koleg", {:field, "a"}, " ni dneva."])
      ),
      test(
        :ednina,
        :zenski,
        parts(["Brez dobr", {:field, "e"}, " prijateljic", {:field, "e"}, " ni dneva."])
      ),
      test(
        :ednina,
        :srednji,
        parts(["Brez dobr", {:field, "ega"}, " dekl", {:field, "eta"}, " ni dneva."])
      ),
      test(
        :dvojina,
        :moski,
        parts(["Brez dobr", {:field, "ih"}, " koleg", {:field, "ov"}, " ni večera."])
      ),
      test(
        :dvojina,
        :zenski,
        parts(["Brez dobr", {:field, "ih"}, " prijateljic", {:field, ""}, " ni večera."])
      ),
      test(
        :dvojina,
        :srednji,
        parts(["Brez dobr", {:field, "ih"}, " dekl", {:field, ""}, " ni večera."])
      ),
      test(
        :mnozina,
        :moski,
        parts(["Brez dobr", {:field, "ih"}, " koleg", {:field, "ov"}, " ni dneva."])
      ),
      test(
        :mnozina,
        :zenski,
        parts(["Brez dobr", {:field, "ih"}, " prijateljic", {:field, ""}, " ni dneva."])
      ),
      test(
        :mnozina,
        :srednji,
        parts(["Brez dobr", {:field, "ih"}, " dekl", {:field, ""}, " ni dneva."])
      )
    ]
  end

  defp test(number, gender, parts) do
    %{case: :rodilnik, number: number, gender: gender, parts: parts}
  end

  defp parts(items) do
    Enum.map(items, fn
      {:field, value} -> %{field: value}
      text -> %{text: text}
    end)
  end
end
