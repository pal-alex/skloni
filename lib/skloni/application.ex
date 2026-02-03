defmodule Skloni.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    _ = Skloni.Mnesia.start()

    children = [
      SkloniWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:skloni, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Skloni.PubSub},
      # Start a worker by calling: Skloni.Worker.start_link(arg)
      # {Skloni.Worker, arg},
      # Start to serve requests, typically the last entry
      SkloniWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Skloni.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SkloniWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
