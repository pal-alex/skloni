defmodule Skloni.Tasks.Orodnik do
  @moduledoc false

  def tests do
    [
      test(
        :ednina,
        :moski,
        parts(["Z dobr", {:field, "im"}, " koleg", {:field, "om"}, " grem."])
      ),
      test(
        :ednina,
        :zenski,
        parts(["Z dobr", {:field, "o"}, " prijateljic", {:field, "o"}, " grem."])
      ),
      test(
        :ednina,
        :srednji,
        parts(["Z dobr", {:field, "im"}, " dekl", {:field, "om"}, " grem."])
      ),
      test(
        :dvojina,
        :moski,
        parts(["Z dobr", {:field, "ima"}, " koleg", {:field, "oma"}, " greva."])
      ),
      test(
        :dvojina,
        :zenski,
        parts(["Z dobr", {:field, "ima"}, " prijateljic", {:field, "ama"}, " greva."])
      ),
      test(
        :dvojina,
        :srednji,
        parts(["Z dobr", {:field, "ima"}, " dekl", {:field, "oma"}, " greva."])
      ),
      test(
        :mnozina,
        :moski,
        parts(["Z dobr", {:field, "imi"}, " koleg", {:field, "i"}, " gremo."])
      ),
      test(
        :mnozina,
        :zenski,
        parts(["Z dobr", {:field, "imi"}, " prijateljic", {:field, "ami"}, " gremo."])
      ),
      test(
        :mnozina,
        :srednji,
        parts(["Z dobr", {:field, "imi"}, " dekl", {:field, "i"}, " gremo."])
      )
    ]
  end

  defp test(number, gender, parts) do
    %{case: :orodnik, number: number, gender: gender, parts: parts}
  end

  defp parts(items) do
    Enum.map(items, fn
      {:field, value} -> %{field: value}
      text -> %{text: text}
    end)
  end
end
