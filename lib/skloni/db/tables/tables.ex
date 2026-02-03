defmodule Skloni.DB.Tables do
  @moduledoc false

  alias Skloni.DB.Tables.{
    Counters,
    MigrationVersions,
    TaskResults,
    TestResults
  }

  def system_tables do
    [Counters, MigrationVersions]
  end

  def domain_tables do
    [TaskResults, TestResults]
  end
end
