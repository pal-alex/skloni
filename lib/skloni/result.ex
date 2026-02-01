defmodule Skloni.Result do
  @moduledoc false

  def get_result(test, answer) do
    expected_endings = Skloni.Tasks.expected_endings(test.parts)
    endings = extract_endings(answer, test.parts)

    passed =
      length(endings) == length(expected_endings) and
        Enum.zip(endings, expected_endings)
        |> Enum.all?(fn {ending, expected} ->
          normalize_ending(ending) == normalize_ending(expected)
        end)

    %{passed: passed, answer: answer}
  end

  def extract_endings(answer, parts) do
    do_extract_endings(answer, parts, [])
    |> Enum.reverse()
  end

  defp do_extract_endings(_answer, [], acc), do: acc

  defp do_extract_endings(answer, [%{text: text} | rest], acc) do
    case find_index(answer, text) do
      nil ->
        do_extract_endings(answer, rest, acc)

      index ->
        start_after = index + byte_size(text)
        remaining = String.slice(answer, start_after, byte_size(answer) - start_after)
        do_extract_endings(remaining, rest, acc)
    end
  end

  defp do_extract_endings(answer, [%{field: _} | rest], acc) do
    next_text = next_text(rest)
    {ending, remaining} = split_by_text(answer, next_text)
    do_extract_endings(remaining, rest, [String.trim_leading(ending) | acc])
  end

  defp next_text(parts) do
    Enum.find_value(parts, fn
      %{text: text} -> text
      _ -> nil
    end)
  end

  defp split_by_text(answer, nil), do: {answer, ""}

  defp split_by_text(answer, text) do
    case find_index(answer, text) do
      nil ->
        {answer, ""}

      index ->
        {
          String.slice(answer, 0, index),
          String.slice(answer, index, byte_size(answer) - index)
        }
    end
  end

  defp find_index(_haystack, ""), do: 0

  defp find_index(haystack, needle) do
    down_haystack = String.downcase(haystack)
    down_needle = String.downcase(needle)

    case :binary.match(down_haystack, down_needle) do
      {index, _} -> index
      :nomatch -> nil
    end
  end

  defp normalize_ending(text) do
    text
    |> String.downcase()
    |> String.replace(~r/[^\p{L}\p{N}]/u, "")
  end
end
