defmodule Directions.RouteGroup do
  @moduledoc false
  @keys [:name, :routes, :base_url]
  @enforce_keys @keys
  defstruct @keys

  alias Directions.RoutesDB

  def find_route(group, search_term) do
    group.routes[RoutesDB.Key.key_for(search_term)]
  end
end
