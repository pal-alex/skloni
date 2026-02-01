defmodule Skloni.ResultTest do
  use ExUnit.Case, async: true

  test "converts user answer into parts with errors and extra words" do
    task = [
      %{parts: [{:text, "Lep"}, {:field, "i"}]},
      %{parts: [{:text, "koleg"}, {:field, "a"}]},
      {:text, " pride."}
    ]

    assert Skloni.Result.answer_parts(task, "Lepa dobra kolega pride.") == [
             %{parts: [{:text, "Lep"}, {:error, "a"}]},
             %{parts: [{:soft_error, "dobra"}]},
             %{parts: [{:text, "koleg"}, {:answer, "a"}]},
             {:text, " pride."}
           ]
  end
end
