defmodule Directions.RoutesDB do
  use GenServer

  alias Directions.{Route, RouteGroup}

  def start_link(_opts \\ []) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def init(route_paths) do
    {:ok, route_paths}
  end

  def groups do
    GenServer.call(__MODULE__, :groups)
  end

  def group(group_name) do
    groups()[group_name]
  end

  def store(routes, group_name, base_url) do
    GenServer.call(__MODULE__, {:store, {routes, group_name, base_url}})
  end

  def handle_call(:groups, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:store, {routes, group_name, base_url}}, _from, state) do
    routes = keyed_routes(routes)

    updated_state =
      Map.put(state, group_name, %RouteGroup{name: group_name, routes: routes, base_url: base_url})

    {:reply, :ok, updated_state}
  end

  defp keyed_routes(routes) when is_list(routes) do
    routes
    |> Enum.reduce(%{}, fn route, acc ->
      Map.put(acc, key_for(route), route)
    end)
  end

  defp key_for(%Route{} = route) do
    route.path_params
    |> Enum.sort()
    |> Enum.reduce("#{route.route_name}#{route.action}", fn path_param, acc ->
      acc <> path_param
    end)
  end
end
