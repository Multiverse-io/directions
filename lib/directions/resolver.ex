defmodule Directions.Resolver do
  alias Directions.{Route, RouteGroup}

  def url(group, search_term) do
    route = RouteGroup.find_route(group, search_term)

    "#{group.base_url}#{Route.apply_path_params(route, search_term.path_params)}"
  end
end
