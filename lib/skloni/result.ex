defmodule Skloni.Result do
  @moduledoc false

  def get_result(test, answer) do
    answer_parts = answer_parts(test.parts, answer)
    passed = not has_errors?(answer_parts)

    %{passed: passed, answer: answer, answer_parts: answer_parts}
  end

  def answer_parts(task_parts, user_input) do
    user_words = tokenize_words(user_input)
    {items, remaining} = build_answer_parts(task_parts, user_words, [])
    extras = Enum.map(remaining, &soft_error_item/1)
    Enum.reverse(items, extras)
  end

  defp build_answer_parts([], user_words, acc), do: {acc, user_words}

  defp build_answer_parts([part | rest], user_words, acc) do
    case part do
      {:text, text} ->
        remaining = consume_text_words(user_words, text)
        build_answer_parts(rest, remaining, [part | acc])

      %{parts: _} = word ->
        if note_only?(word) do
          build_answer_parts(rest, user_words, [word | acc])
        else
          {items, remaining} = match_word(word, user_words, [])
          build_answer_parts(rest, remaining, Enum.reverse(items) ++ acc)
        end

      _ ->
        build_answer_parts(rest, user_words, acc)
    end
  end

  defp match_word(word, [], acc) do
    {Enum.reverse([replace_field(word, :error, "") | acc]), []}
  end

  defp match_word(word, [user_word | rest], acc) do
    {prefix, suffix, expected} = word_shape(word)

    if matches_word?(user_word, prefix, suffix) do
      user_field = extract_field(user_word, prefix, suffix)

      type =
        if normalize(user_field) == normalize(expected) do
          :answer
        else
          :error
        end

      remaining = consume_following_text(rest, word)
      {Enum.reverse([replace_field(word, type, user_field) | acc]), remaining}
    else
      match_word(word, rest, [soft_error_item(user_word) | acc])
    end
  end

  defp word_shape(%{parts: parts}) do
    {prefix_parts, suffix_parts} = split_field(parts, [], [])
    prefix = parts_text(prefix_parts)
    suffix = parts_text(suffix_parts)
    expected = field_value(parts)
    {prefix, suffix, expected}
  end

  defp split_field([], prefix, suffix), do: {Enum.reverse(prefix), Enum.reverse(suffix)}

  defp split_field([{:field, _value} | rest], prefix, _suffix) do
    {Enum.reverse(prefix), rest}
  end

  defp split_field([part | rest], prefix, suffix) do
    split_field(rest, [part | prefix], suffix)
  end

  defp parts_text(parts) do
    parts
    |> Enum.reduce("", fn
      {:text, text}, acc -> acc <> text
      {:note, _value}, acc -> acc
      _part, acc -> acc
    end)
  end

  defp field_value(parts) do
    Enum.find_value(parts, "", fn
      {:field, value} -> value
      _ -> nil
    end)
  end

  defp matches_word?(word, prefix, suffix) do
    word = normalize(word)
    prefix = normalize(prefix)
    suffix = normalize(suffix)

    (prefix == "" or String.starts_with?(word, prefix)) and
      (suffix == "" or String.ends_with?(word, suffix))
  end

  defp extract_field(word, prefix, suffix) do
    total_len = String.length(word)
    prefix_len = String.length(prefix)
    suffix_len = String.length(suffix)
    middle_len = max(total_len - prefix_len - suffix_len, 0)
    String.slice(word, prefix_len, middle_len)
  end

  defp replace_field(%{parts: parts}, type, value) do
    %{parts: Enum.map(parts, &replace_token(&1, type, value))}
  end

  defp replace_token({:field, _}, type, value), do: {type, value}
  defp replace_token(token, _type, _value), do: token

  defp soft_error_item(word) do
    %{parts: [{:soft_error, word}]}
  end

  defp note_only?(%{parts: parts}) do
    Enum.all?(parts, fn
      {:note, _value} -> true
      _ -> false
    end)
  end

  defp consume_text_words(user_words, text) do
    text_words = tokenize_words(text)
    drop_matching(user_words, text_words)
  end

  defp consume_following_text(user_words, word) do
    suffix_words = word_suffix_words(word)
    drop_matching(user_words, suffix_words)
  end

  defp word_suffix_words(%{parts: parts}) do
    {_prefix_parts, suffix_parts} = split_field(parts, [], [])

    parts_text(suffix_parts)
    |> tokenize_words()
  end

  defp drop_matching(user_words, []), do: user_words
  defp drop_matching([], _text_words), do: []

  defp drop_matching([user_word | rest], [text_word | remaining]) do
    if normalize(user_word) == normalize(text_word) do
      drop_matching(rest, remaining)
    else
      [user_word | rest]
    end
  end

  defp tokenize_words(text) do
    Regex.scan(~r/[\p{L}\p{N}]+/u, text)
    |> List.flatten()
  end

  defp normalize(text) do
    text
    |> String.downcase()
    |> String.replace(~r/[^\p{L}\p{N}]/u, "")
  end

  defp has_errors?(items) do
    Enum.any?(items, fn
      %{parts: parts} -> Enum.any?(parts, fn {type, _} -> type == :error end)
      _ -> false
    end)
  end
end
