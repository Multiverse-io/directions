defmodule Directions.Application do
  use Application

  def start(_type, _args) do
    children = [Directions.RoutesDB]
    {:ok, pid} = Supervisor.start_link(children, strategy: :one_for_one)

    Application.get_env(:directions, :route_sources, [])
    |> Enum.each(fn spec ->
      IO.inspect(spec)
    end)

    {:ok, pid, %{dbs: %{}}}
  end
end
