defmodule SkloniWeb.InflectionLive do
  use SkloniWeb, :live_view

  def mount(_params, _session, socket) do
    tests = Skloni.Tasks.all_tests()

    socket =
      socket
      |> assign(:tests, tests)
      |> assign(:test_index, 0)
      |> assign(:current_test, Enum.at(tests, 0))
      |> assign(:feed, [])
      |> assign(:total, 0)
      |> assign(:passed, 0)
      |> assign(:input, "")

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="app-shell">
      <header class="control-panel">
        <div class="brand">
          <div class="brand-mark">SK</div>
          <div>
            <div class="brand-title">Skloni</div>
            <div class="brand-subtitle">Slovenian inflection drills</div>
          </div>
        </div>
        <div class="stats">
          <div class="stat-card">
            <div class="stat-label">All tests</div>
            <div class="stat-value">{@total}</div>
          </div>
          <div class="stat-card">
            <div class="stat-label">Passed</div>
            <div class="stat-value">{@passed}</div>
          </div>
          <button type="button" class="start-btn" phx-click="start">Start</button>
        </div>
      </header>

      <main class="chat">
        <section class="feed" aria-live="polite">
          <%= if Enum.empty?(@feed) do %>
            <div class="empty-state">
              <div class="empty-title">No attempts yet</div>
              <div class="empty-body">Fill the endings and send your answer to begin.</div>
            </div>
          <% else %>
            <%= for item <- @feed do %>
              <article class={"bubble #{if item.correct?, do: "ok", else: "bad"}"}>
                <div class="bubble-header">
                  <span class="bubble-label">Test</span>
                  <span class={"status-badge #{if item.correct?, do: "ok", else: "bad"}"}>
                    {if item.correct?, do: "Correct", else: "Needs work"}
                  </span>
                </div>
                <div class="bubble-prompt">
                  <%= for part <- item.parts do %>
                    {render_prompt_part(part)}
                  <% end %>
                </div>
                <div class="bubble-row">
                  <div class="bubble-key">Your answer</div>
                  <div class={"bubble-value #{if item.correct?, do: "answer-ok", else: ""}"}>
                    <%= for segment <- answer_segments_from_parts(item.parts, item.endings, item.expected_endings) do %>
                      <span class={segment.class}>{segment.text}</span>
                    <% end %>
                  </div>
                </div>
                <%= if not item.correct? do %>
                  <div class="bubble-row">
                    <div class="bubble-key">Correct endings</div>
                    <div class="bubble-value answer-ok">
                      {Enum.join(item.expected_endings, " · ")}
                    </div>
                  </div>
                <% end %>
              </article>
            <% end %>
          <% end %>
        </section>

        <section class="composer">
          <div class="prompt">
            <div class="prompt-label">Fill the endings</div>
            <div class="prompt-text">
              <%= for part <- @current_test.parts do %>
                {render_prompt_part(part)}
              <% end %>
            </div>
          </div>
          <.form for={%{}} as={:entry} phx-submit="submit" phx-change="typing" class="input-row">
            <input
              id="inflection-answer"
              class="answer-input"
              type="text"
              name="entry[answer]"
              value={@input}
              autocomplete="off"
              spellcheck="false"
              placeholder="Type full phrase with endings"
              phx-hook="CtrlEnterSubmit"
              phx-debounce="300"
            />
            <button class="send-btn" type="submit">Send</button>
          </.form>
        </section>
      </main>
    </div>
    """
  end

  def handle_event("typing", %{"entry" => %{"answer" => answer}}, socket) do
    {:noreply, assign(socket, :input, answer)}
  end

  def handle_event("submit", %{"entry" => %{"answer" => answer}}, socket) do
    answer = String.trim(answer || "")

    if answer == "" do
      {:noreply, socket}
    else
      current = socket.assigns.current_test
      result = Skloni.Result.get_result(current, answer)
      endings = Skloni.Result.extract_endings(result.answer, current.parts)
      expected_endings = Skloni.Tasks.expected_endings(current.parts)
      correct? = result.passed

      feed_item = %{
        parts: current.parts,
        answer: result.answer,
        endings: endings,
        expected_endings: expected_endings,
        correct?: correct?
      }

      next_index = next_test_index(socket.assigns.test_index, socket.assigns.tests)

      socket =
        socket
        |> assign(:feed, [feed_item | socket.assigns.feed])
        |> assign(:total, socket.assigns.total + 1)
        |> assign(:passed, socket.assigns.passed + if(correct?, do: 1, else: 0))
        |> assign(:test_index, next_index)
        |> assign(:current_test, Enum.at(socket.assigns.tests, next_index))
        |> assign(:input, "")

      {:noreply, socket}
    end
  end

  def handle_event("start", _params, socket) do
    first_test = Enum.at(socket.assigns.tests, 0)

    socket =
      socket
      |> assign(:feed, [])
      |> assign(:total, 0)
      |> assign(:passed, 0)
      |> assign(:test_index, 0)
      |> assign(:current_test, first_test)
      |> assign(:input, "")

    {:noreply, socket}
  end

  defp next_test_index(current_index, tests) do
    if length(tests) == 0 do
      0
    else
      rem(current_index + 1, length(tests))
    end
  end

  defp answer_segments_from_parts(parts, endings, expected_endings) do
    endings = pad_list(endings, count_fields(parts))
    expected_endings = pad_list(expected_endings, count_fields(parts))

    {segments, _} =
      Enum.reduce(parts, {[], 0}, fn part, {acc, index} ->
        if is_map(part) do
          ending = Enum.at(endings, index, "")
          expected = Enum.at(expected_endings, index, "")
          class = ending_class(ending, expected)
          {prepend_segment(acc, ending, class), index + 1}
        else
          {prepend_segment(acc, part, nil), index}
        end
      end)

    Enum.reverse(segments)
  end

  defp count_fields(parts) do
    parts
    |> Enum.count(&is_map/1)
  end

  defp pad_list(list, size) do
    list ++ List.duplicate("", max(size - length(list), 0))
  end

  defp ending_class("", ""), do: nil

  defp ending_class(ending, expected) do
    if normalize_ending(ending) == normalize_ending(expected) do
      "answer-ok"
    else
      "answer-bad"
    end
  end

  defp normalize_ending(text) do
    text
    |> String.downcase()
    |> String.replace(~r/[^\p{L}\p{N}]/u, "")
  end

  defp prepend_segment(segments, "", _class), do: segments
  defp prepend_segment(segments, text, class), do: [%{text: text, class: class} | segments]

  defp render_prompt_part(%{text: text, field: _field}) do
    assigns = %{text: text}

    ~H"""
    <span class="prompt-token flex"><span>{@text}</span><span class="prompt-field"></span></span>
    """
  end

  defp render_prompt_part(text) when is_binary(text) do
    assigns = %{text: text}

    ~H"""
    <span>{@text}</span>
    """
  end
end
