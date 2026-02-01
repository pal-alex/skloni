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
                  {show_phrase(item.task_parts, show_answers: false)}
                </div>
                <div class="bubble-row">
                  <div class="bubble-key">Your answer</div>
                  <div class={"bubble-value #{if item.correct?, do: "answer-ok", else: ""}"}>
                    {show_phrase(item.answer_parts, show_answers: true)}
                  </div>
                </div>
                <%= if not item.correct? do %>
                  <div class="bubble-row">
                    <div class="bubble-key">Correct answer</div>
                    <div class="bubble-value">
                      {show_phrase(item.task_parts, show_answers: true)}
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
              {show_phrase(@current_test.parts, show_answers: false)}
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
      correct? = result.passed

      feed_item = %{
        task_parts: current.parts,
        answer_parts: result.answer_parts,
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

  defp show_phrase(parts, opts) do
    assigns = %{parts: parts, show_answers: Keyword.get(opts, :show_answers, false)}

    ~H"""
    <%= for part <- @parts do %>
      {render_phrase_part(part, @show_answers)}
    <% end %>
    """
  end

  defp render_phrase_part({:text, text}, _show_answers) do
    assigns = %{text: text}

    ~H"""
    <span>{@text}</span>
    """
  end

  defp render_phrase_part(%{parts: parts}, show_answers) do
    assigns = %{parts: parts, show_answers: show_answers}

    ~H"""
    <span class="prompt-token flex">
      <%= for token <- @parts do %>
        {render_phrase_token(token, @show_answers)}
      <% end %>
    </span>
    """
  end

  defp render_phrase_token({:text, text}, _show_answers) do
    assigns = %{text: text}

    ~H"""
    <span>{@text}</span>
    """
  end

  defp render_phrase_token({:field, value}, true) do
    assigns = %{value: value}

    ~H"""
    <span class="field-answer">{@value}</span>
    """
  end

  defp render_phrase_token({:field, _value}, false) do
    assigns = %{}

    ~H"""
    <span class="prompt-field"></span>
    """
  end

  defp render_phrase_token({:note, value}, _show_answers) do
    assigns = %{value: value}

    ~H"""
    <span class="prompt-note">{@value}</span>
    """
  end

  defp render_phrase_token({:answer, value}, _show_answers) do
    assigns = %{value: value}

    ~H"""
    <span class="field-answer">{@value}</span>
    """
  end

  defp render_phrase_token({:error, value}, _show_answers) do
    assigns = %{value: error_display(value)}

    ~H"""
    <span class="field-error">{@value}</span>
    """
  end

  defp render_phrase_token({:soft_error, value}, _show_answers) do
    assigns = %{value: value}

    ~H"""
    <span class="field-soft">{@value}</span>
    """
  end

  defp error_display(""), do: "?"
  defp error_display(value), do: value
end
