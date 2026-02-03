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

  test "keeps user endings when prompt includes leading fixed text" do
    task =
      Skloni.Tests.Skloni.tasks()
      |> Enum.map(&Skloni.Tasks.Format.from_raw_task/1)
      |> Enum.find(&(&1.case == :tozhilnik and &1.number == :ednina and &1.gender == :srednji))

    assert Skloni.Result.answer_parts(task.parts, "Vidim dobra mesta.") == [
             %{parts: [{:note, "{1}"}]},
             {:text, " Vidim "},
             %{parts: [{:text, "dobr"}, {:error, "a"}]},
             {:text, " "},
             %{parts: [{:text, "mest"}, {:error, "a"}]},
             {:text, "."}
           ]
  end
end
