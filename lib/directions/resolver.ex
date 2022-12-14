defmodule Directions.Resolver do
  @moduledoc false
  alias Directions.{Route, RouteGroup}

  def url(group, search_term) do
    route = RouteGroup.find_route(group, search_term)

    if route do
      {:ok, "#{group.base_url}#{Route.apply_path_params(route, search_term.path_params)}"}
    else
      {:error, :route_not_found, search_term}
    end
  end
end
