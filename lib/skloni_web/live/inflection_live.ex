defmodule SkloniWeb.InflectionLive do
  use SkloniWeb, :live_view

  def mount(_params, _session, socket) do
    form = to_form(%{"answer" => ""}, as: :entry)

    socket =
      socket
      |> assign(:tasks, [])
      |> assign(:task_index, 0)
      |> assign(:current_task, nil)
      |> assign(:feed, [])
      |> assign(:total, 0)
      |> assign(:passed, 0)
      |> assign(:form, form)
      |> assign(:current_test_id, nil)
      |> assign(:test_active, false)
      |> assign(:current_scope, nil)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <div class="app-shell">
        <aside class="control-panel">
          <div class="brand">
            <div class="brand-mark">SK</div>
            <div>
              <div class="brand-title">Skloni</div>
              <div class="brand-subtitle">Slovenian inflection drills</div>
            </div>
          </div>
          <div class="stats">
            <div class="stat-card">
              <div class="stat-label">All tasks</div>
              <div class="stat-value">{@total}</div>
            </div>
            <div class="stat-card">
              <div class="stat-label">Passed</div>
              <div class="stat-value">{@passed}</div>
            </div>
            <button type="button" class="start-btn" phx-click="start">Start</button>
          </div>
        </aside>

        <main class="chat">
          <section id="feed" class="feed" aria-live="polite" phx-hook="ScrollFeed">
            <%= if Enum.empty?(@feed) do %>
              <div class="empty-state">
                <div class="empty-title">No attempts yet</div>
                <div class="empty-body">Click Start to begin your test.</div>
              </div>
            <% else %>
              <%= for item <- @feed do %>
                <article class={"bubble #{if item.correct?, do: "ok", else: "bad"}"}>
                  <div class="bubble-header">
                    <span class="bubble-label">Task</span>
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
            <%= if @current_task do %>
              <div class="prompt">
                <div class="prompt-label">Fill the endings</div>
                <div class="prompt-text">
                  {show_phrase(@current_task.parts, show_answers: false)}
                </div>
              </div>
            <% else %>
              <div class="prompt">
                <div class="prompt-label">Test ready</div>
                <div class="prompt-text">Click Start to begin a new test.</div>
              </div>
            <% end %>
            <.form
              for={@form}
              id="inflection-form"
              phx-submit="submit"
              phx-change="typing"
              class="input-row"
            >
              <.input
                id="inflection-answer"
                field={@form[:answer]}
                type="text"
                class="answer-input"
                autocomplete="off"
                spellcheck="false"
                placeholder={
                  if @current_task,
                    do: "Type full phrase with endings",
                    else: "Start the test to answer"
                }
                phx-hook="CtrlEnterSubmit"
                phx-debounce="300"
                disabled={!@current_task}
              />
              <button class="send-btn" type="submit" disabled={!@current_task}>Send</button>
            </.form>
          </section>
        </main>
      </div>
    </Layouts.app>
    """
  end

  def handle_event("typing", %{"entry" => %{"answer" => answer}}, socket) do
    {:noreply, assign(socket, :form, to_form(%{"answer" => answer}, as: :entry))}
  end

  def handle_event("submit", %{"entry" => %{"answer" => answer}}, socket) do
    answer = String.trim(answer || "")

    if answer == "" or is_nil(socket.assigns.current_task) do
      {:noreply, socket}
    else
      user_id = Skloni.Tests.default_user_id()
      current = socket.assigns.current_task
      result = Skloni.Result.get_result(current, answer)
      correct? = result.passed

      _ = Skloni.Tests.record_task_attempt(user_id, current, correct?)

      if socket.assigns.current_test_id do
        _ = Skloni.Tests.record_test_attempt(socket.assigns.current_test_id, correct?)
      end

      feed_item = %{
        task_parts: current.parts,
        answer_parts: result.answer_parts,
        correct?: correct?
      }

      next_index = socket.assigns.task_index + 1
      next_task = Enum.at(socket.assigns.tasks, next_index)

      {next_task, test_active} =
        if is_nil(next_task) do
          if socket.assigns.current_test_id do
            _ = Skloni.Tests.finish_test(socket.assigns.current_test_id)
          end

          {nil, false}
        else
          {next_task, true}
        end

      socket =
        socket
        |> assign(:feed, socket.assigns.feed ++ [feed_item])
        |> assign(:total, socket.assigns.total + 1)
        |> assign(:passed, socket.assigns.passed + if(correct?, do: 1, else: 0))
        |> assign(:task_index, next_index)
        |> assign(:current_task, next_task)
        |> assign(:form, to_form(%{"answer" => ""}, as: :entry))
        |> assign(:test_active, test_active)

      {:noreply, socket}
    end
  end

  def handle_event("start", _params, socket) do
    user_id = Skloni.Tests.default_user_id()

    if socket.assigns.current_test_id do
      _ = Skloni.Tests.finish_test(socket.assigns.current_test_id)
    end

    tasks = Skloni.Tests.build_test_tasks(user_id)
    first_task = Enum.at(tasks, 0)
    test_id = Skloni.Tests.start_test(user_id)

    socket =
      socket
      |> assign(:feed, [])
      |> assign(:total, 0)
      |> assign(:passed, 0)
      |> assign(:tasks, tasks)
      |> assign(:task_index, 0)
      |> assign(:current_task, first_task)
      |> assign(:form, to_form(%{"answer" => ""}, as: :entry))
      |> assign(:current_test_id, test_id)
      |> assign(:test_active, not is_nil(first_task))

    {:noreply, socket}
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
