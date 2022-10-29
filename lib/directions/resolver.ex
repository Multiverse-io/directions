defmodule Directions.Resolver do
  alias Directions.{Route, RouteGroup}

  def url(group, route_name, path_params \\ []) do
    route_name = Atom.to_string(route_name)

    route = RouteGroup.find_route(group, route_name, path_params)

    "#{group.base_url}#{Route.apply_path_params(route, path_params)}"
  end
end
