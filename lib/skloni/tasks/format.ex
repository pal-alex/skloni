defmodule Skloni.Tasks.Format do
  @moduledoc false

  @number_labels %{
    ednina: "ednina",
    dvojina: "dvojina",
    mnozina: "množina"
  }

  @gender_labels %{
    moski: "moški spol",
    zenski: "ženski spol",
    srednji: "srednji spol"
  }

  @case_labels %{
    imenovalnik: "imenovalnik",
    rodilnik: "rodilnik",
    dajalnik: "dajalnik",
    tozhilnik: "tožilnik",
    mestnik: "mestnik",
    orodnik: "orodnik"
  }

  @number_map %{
    "ednina" => :ednina,
    "dvojina" => :dvojina,
    "mnozina" => :mnozina
  }

  @gender_map %{
    "moski" => :moski,
    "moski spol" => :moski,
    "mozski" => :moski,
    "mozski spol" => :moski,
    "zenski" => :zenski,
    "zenski spol" => :zenski,
    "srednji" => :srednji,
    "srednji spol" => :srednji
  }

  @case_map %{
    "imenovalnik" => :imenovalnik,
    "rodilnik" => :rodilnik,
    "dajalnik" => :dajalnik,
    "tozilnik" => :tozhilnik,
    "tozhilnik" => :tozhilnik,
    "mestnik" => :mestnik,
    "orodnik" => :orodnik
  }

  def comment(number, gender, case_name) do
    [label(@number_labels, number), label(@gender_labels, gender), label(@case_labels, case_name)]
    |> Enum.join(", ")
  end

  def from_raw_task({test_id, task_id, task_text, comments}) do
    {number, gender, case_name} = parse_comments(comments)

    %{
      test_id: test_id,
      task_id: task_id,
      task: task_text,
      comments: comments,
      parts: parse_task_parts(task_text),
      case: case_name,
      number: number,
      gender: gender
    }
  end

  def parse_task_parts(task_text) do
    task_text
    |> do_parse_task_parts([])
    |> Enum.reverse()
  end

  def parts_to_text(parts) do
    {output, _} =
      Enum.reduce(parts, {"", nil}, fn part, {acc, prev_type} ->
        {segment, type} =
          case part do
            {:text, text} ->
              {text, :text}

            %{parts: tokens} ->
              token_text =
                tokens
                |> Enum.map(fn
                  {:text, text} -> text
                  {:field, value} -> "[#{value}]"
                  {:note, value} -> note_text(value)
                  _ -> ""
                end)
                |> Enum.join("")

              {token_text, :word}

            _ ->
              {"", :other}
          end

        acc =
          if type == :word and prev_type == :word and not String.ends_with?(acc, " ") do
            acc <> " " <> segment
          else
            acc <> segment
          end

        {acc, type}
      end)

    output
  end

  def parse_comments(comments) do
    tokens =
      comments
      |> String.split(",")
      |> Enum.map(&String.trim/1)
      |> Enum.reject(&(&1 == ""))

    {number, gender, case_name} =
      Enum.reduce(tokens, {nil, nil, nil}, fn token, {number, gender, case_name} ->
        normalized = normalize_label(token)

        cond do
          Map.has_key?(@number_map, normalized) ->
            {Map.fetch!(@number_map, normalized), gender, case_name}

          Map.has_key?(@gender_map, normalized) ->
            {number, Map.fetch!(@gender_map, normalized), case_name}

          Map.has_key?(@case_map, normalized) ->
            {number, gender, Map.fetch!(@case_map, normalized)}

          true ->
            {number, gender, case_name}
        end
      end)

    if is_nil(number) or is_nil(gender) or is_nil(case_name) do
      raise ArgumentError,
            "Invalid task comments: #{comments}. Expected number, gender, case (e.g. \"ednina, moški spol, dajalnik\")."
    end

    {number, gender, case_name}
  end

  defp do_parse_task_parts("", acc), do: acc

  defp do_parse_task_parts(text, acc) do
    case next_match(text) do
      nil ->
        if text == "" do
          acc
        else
          [{:text, text} | acc]
        end

      {:note, start, len} ->
        acc = add_prefix_text(text, start, acc)
        match = slice_bytes(text, start, len)
        rest = slice_rest(text, start, len)
        do_parse_task_parts(rest, [%{parts: [{:note, match}]} | acc])

      {:field, start, len} ->
        acc = add_prefix_text(text, start, acc)
        match = slice_bytes(text, start, len)
        rest = slice_rest(text, start, len)
        do_parse_task_parts(rest, [%{parts: parse_word_parts(match)} | acc])
    end
  end

  defp add_prefix_text(text, start, acc) do
    if start > 0 do
      prefix = slice_bytes(text, 0, start)
      if prefix == "", do: acc, else: [{:text, prefix} | acc]
    else
      acc
    end
  end

  defp next_match(text) do
    note_match = Regex.run(~r/\{[^}]*\}/u, text, return: :index)
    field_match = Regex.run(~r/[\p{L}\p{N}]*\[[^\]]*\][\p{L}\p{N}]*/u, text, return: :index)

    note_pos = match_position(note_match)
    field_pos = match_position(field_match)

    case {note_pos, field_pos} do
      {nil, nil} ->
        nil

      {note, nil} ->
        {:note, elem(note, 0), elem(note, 1)}

      {nil, field} ->
        {:field, elem(field, 0), elem(field, 1)}

      {note, field} ->
        if elem(note, 0) <= elem(field, 0) do
          {:note, elem(note, 0), elem(note, 1)}
        else
          {:field, elem(field, 0), elem(field, 1)}
        end
    end
  end

  defp match_position([{start, len} | _]), do: {start, len}
  defp match_position(_), do: nil

  defp parse_word_parts(word) do
    segments =
      Regex.split(~r/\[([^\]]*)\]/u, word, include_captures: true, trim: false)

    tokens =
      segments
      |> Enum.with_index()
      |> Enum.reduce([], fn {segment, index}, acc ->
        if rem(index, 2) == 1 do
          [{:field, segment} | acc]
        else
          if segment == "", do: acc, else: [{:text, segment} | acc]
        end
      end)
      |> Enum.reverse()

    if tokens == [] do
      [{:text, word}]
    else
      tokens
    end
  end

  defp note_text(value) do
    trimmed = String.trim(value)

    cond do
      String.starts_with?(trimmed, "{") and String.ends_with?(trimmed, "}") ->
        trimmed

      String.starts_with?(trimmed, "[") and String.ends_with?(trimmed, "]") ->
        inner =
          trimmed
          |> String.trim_leading("[")
          |> String.trim_trailing("]")

        "{" <> inner <> "}"

      true ->
        "{" <> trimmed <> "}"
    end
  end

  defp label(map, key) do
    Map.fetch!(map, key)
  end

  defp normalize_label(label) do
    label
    |> String.downcase()
    |> String.replace(~r/\s+/u, " ")
    |> String.trim()
    |> String.replace("č", "c")
    |> String.replace("ć", "c")
    |> String.replace("š", "s")
    |> String.replace("ž", "z")
    |> String.replace("đ", "d")
  end

  defp slice_bytes(text, start, len) do
    :binary.part(text, start, len)
  end

  defp slice_rest(text, start, len) do
    total = byte_size(text)
    rest_start = start + len

    if rest_start >= total do
      ""
    else
      :binary.part(text, rest_start, total - rest_start)
    end
  end
end
