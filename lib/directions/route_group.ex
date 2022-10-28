defmodule Directions.RouteGroup do
  @keys [:name, :routes, :base_url]
  @enforce_keys @keys
  defstruct @keys
end
