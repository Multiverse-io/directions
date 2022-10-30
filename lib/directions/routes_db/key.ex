defmodule Directions.RoutesDB.Key do
  alias Directions.{Route, SearchTerm}

  def key_for(%SearchTerm{} = search_term) do
    search_term.path_params
    |> Keyword.keys()
    |> Enum.sort()
    |> Enum.reduce("#{search_term.route_name}:#{search_term.action}", fn path_param, acc ->
      "#{acc}:#{path_param}"
    end)
  end

  def key_for(%Route{} = route) do
    route.path_params
    |> Enum.sort()
    |> Enum.reduce("#{route.route_name}#{route.action}", fn path_param, acc ->
      acc <> path_param
    end)
  end
end
