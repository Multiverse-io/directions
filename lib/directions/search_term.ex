defmodule Directions.SearchTerm do
  @moduledoc """
  Represents a routes search
  """

  @keys [:group_name, :route_name, :action, :path_params]
  @enforce_keys @keys
  defstruct @keys
end
