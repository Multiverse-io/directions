defmodule Directions.Route do
  @keys [:route_name, :path_pattern, :controller, :action]
  @enforce_keys @keys
  defstruct @keys

  def from_map(%{"action" => action, "controller" => controller, "path_pattern" => path_pattern, "route_name" => route_name}) do
    %__MODULE__{
      action: action,
      controller: controller,
      path_pattern: path_pattern,
      route_name: route_name
    }
  end
end
