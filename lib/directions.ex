defmodule Directions do
  alias Directions.{Resolver, RoutesDB, SearchTerm}

  def url(group_name, route_name, action, path_params \\ []) do
    search_term = %SearchTerm{
      group_name: group_name,
      route_name: route_name,
      action: action,
      path_params: path_params
    }

    group = RoutesDB.group(group_name)

    Resolver.url(group, search_term)
  end
end
