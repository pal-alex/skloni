defmodule Skloni.DB.Tables do
  @moduledoc false

  alias Skloni.DB.Tables.{
    Counters,
    MigrationVersions,
    TaskResults,
    TestResults,
    UserTokens,
    Users
  }

  def system_tables do
    [Counters, MigrationVersions]
  end

  def domain_tables do
    [TaskResults, TestResults, Users, UserTokens]
  end

  def results_tables do
    [TaskResults, TestResults]
  end

  def user_tables do
    [Users, UserTokens]
  end
end
