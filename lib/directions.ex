defmodule Directions do
  alias Directions.{Resolver, RoutesDB}

  def url(group_name, route_name, bindings \\ []) do
    group = RoutesDB.group(group_name)

    Resolver.url(group, route_name, bindings)
  end
end
