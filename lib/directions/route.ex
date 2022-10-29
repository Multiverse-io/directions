defmodule Directions.Route do
  @keys [:route_name, :path_pattern, :controller, :action, :path_params]
  @enforce_keys @keys
  defstruct @keys

  def from_map(%{
        "action" => action,
        "controller" => controller,
        "path_pattern" => path_pattern,
        "route_name" => route_name
      }) do
    %__MODULE__{
      action: action,
      controller: controller,
      path_pattern: path_pattern,
      route_name: route_name,
      path_params: path_params_in(path_pattern)
    }
  end

  def apply_path_params(route, path_params) do
    path_params
    |> Enum.reduce(route.path_pattern, fn {k, v}, url ->
      String.replace(url, ~r/:#{Atom.to_string(k)}/, to_string(v))
    end)
  end

  defp path_params_in(path_pattern) do
    path_pattern
    |> String.split("/")
    |> Enum.filter(&String.starts_with?(&1, ":"))
    |> Enum.sort()
  end
end
