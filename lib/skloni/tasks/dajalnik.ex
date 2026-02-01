defmodule Skloni.Tasks.Dajalnik do
  @moduledoc false

  def tests do
    [
      test(
        :ednina,
        :moski,
        parts(["K dobr", {:field, "emu"}, " koleg", {:field, "u"}, " grem."])
      ),
      test(
        :ednina,
        :zenski,
        parts(["K dobr", {:field, "i"}, " prijateljic", {:field, "i"}, " grem."])
      ),
      test(
        :ednina,
        :srednji,
        parts(["K dobr", {:field, "emu"}, " dekl", {:field, "u"}, " grem."])
      ),
      test(
        :dvojina,
        :moski,
        parts(["K dobr", {:field, "ima"}, " koleg", {:field, "oma"}, " greva."])
      ),
      test(
        :dvojina,
        :zenski,
        parts(["K dobr", {:field, "ima"}, " prijateljic", {:field, "ama"}, " greva."])
      ),
      test(
        :dvojina,
        :srednji,
        parts(["K dobr", {:field, "ima"}, " dekl", {:field, "oma"}, " greva."])
      ),
      test(
        :mnozina,
        :moski,
        parts(["K dobr", {:field, "im"}, " koleg", {:field, "om"}, " gremo."])
      ),
      test(
        :mnozina,
        :zenski,
        parts(["K dobr", {:field, "im"}, " prijateljic", {:field, "am"}, " gremo."])
      ),
      test(
        :mnozina,
        :srednji,
        parts(["K dobr", {:field, "im"}, " dekl", {:field, "om"}, " gremo."])
      )
    ]
  end

  defp test(number, gender, parts) do
    %{case: :dajalnik, number: number, gender: gender, parts: parts}
  end

  defp parts(items) do
    Enum.map(items, fn
      {:field, value} -> %{field: value}
      text -> %{text: text}
    end)
  end
end
