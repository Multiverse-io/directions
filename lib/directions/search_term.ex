defmodule Directions.SearchTerm do
  @moduledoc false
  @keys [:group_name, :route_name, :action, :path_params]
  @enforce_keys @keys
  defstruct @keys
end
