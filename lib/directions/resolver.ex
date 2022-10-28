defmodule Directions.Resolver do
  def url(group, route_name, bindings \\ []) do
    route_name = Atom.to_string(route_name)

    route =
      group.routes
      |> Enum.find(fn entry ->
        entry["route_name"] == route_name
      end)
    "#{group.base_url}#{route["path_pattern"]}"
  end
end
