defmodule Directions do
  alias Directions.{Resolver, RoutesDB}

  def url(group_name, route_name, path_params \\ []) do
    group = RoutesDB.group(group_name)

    Resolver.url(group, route_name, path_params)
  end
end
