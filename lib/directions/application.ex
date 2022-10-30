defmodule Directions.Application do
  @moduledoc false
  use Application

  alias Directions.SourcesLoader

  def start(_type, _args) do
    children = [Directions.RoutesDB]
    {:ok, pid} = Supervisor.start_link(children, strategy: :one_for_one)

    SourcesLoader.load()

    {:ok, pid, %{dbs: %{}}}
  end
end
