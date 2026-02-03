defmodule Skloni.Mnesia do
  @moduledoc false

  use GenServer

  @compile {:no_warn_undefined, :mnesia}

  def child_spec(_opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [[]]},
      type: :worker
    }
  end

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @impl true
  def init(:ok) do
    _ = start()
    {:ok, %{}}
  end

  @impl true
  def terminate(_reason, _state) do
    _ = stop()
    :ok
  end

  def start do
    dir = Application.fetch_env!(:mnesia, :dir)
    dir_path = List.to_string(dir)

    File.mkdir_p!(dir_path)

    :mnesia.stop()
    :mnesia.change_config(:dir, dir)

    schema_path = Path.join(dir_path, "schema.DAT")

    if not File.exists?(schema_path) do
      :ok = :mnesia.create_schema([node()])
    end

    :ok = :mnesia.start()
    :ok = :mnesia.wait_for_tables([:schema], 5_000)

    Skloni.DB.Migrator.run!()
  end

  def stop do
    :mnesia.stop()
  end
end
