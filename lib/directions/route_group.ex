defmodule Directions.RouteGroup do
  @keys [:name, :routes, :base_url]
  @enforce_keys @keys
  defstruct @keys

  alias Directions.SearchTerm

  def find_route(group, search_term) do
    group.routes[key_for(search_term)]
  end

  # TODO: This should not be here! It does not belong here!
  # This should be SearchTerm.to_string(search_term)!!!!!
  # This should be SearchTerm.to_string(search_term)!!!!!
  # This should be SearchTerm.to_string(search_term)!!!!!
  # This should be SearchTerm.to_string(search_term)!!!!!
  # This should be SearchTerm.to_string(search_term)!!!!!
  #
  # OR
  #
  # Create a fnction in SearchTerm that returns the struct from
  # a map or something else, add a new field in the struct for the stringified
  # version of the search term, generate that string when building the struct!
  # (but then a struct can be generated without using that function and the stringified search
  # term field be set to something else...)
  defp key_for(%SearchTerm{} = search_term) do
    search_term.path_params
    |> Enum.sort()
    |> Keyword.keys()
    |> Enum.reduce("#{search_term.route_name}:#{search_term.action}", fn path_param, acc ->
      "#{acc}:#{path_param}"
    end)
  end
end
