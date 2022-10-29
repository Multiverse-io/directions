defmodule Directions.RouteGroup do
  @keys [:name, :routes, :base_url]
  @enforce_keys @keys
  defstruct @keys

  def find_route(group, route_name, path_params) do
    group.routes[key_for(route_name, path_params)]
  end

  defp key_for(route_name, path_params) do
    path_params
    |> Keyword.keys()
    |> Enum.reduce(route_name, fn path_param, acc ->
      "#{acc}:#{path_param}"
    end)
  end
end
