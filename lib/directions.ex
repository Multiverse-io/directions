defmodule Directions do
  alias Directions.{Resolver, RoutesDB, SearchTerm}

  @doc """
  Generates a URL

  ## Arguments:

  - `group_name`: The name of the routes group, as defined in the library configuration for each
    of the loaded routes files.
  - `route_name`: The name of route, matching one of the routes listed within the route file
  - `action`: The name of the action for the given route
  - `path_params`: Keyword list with the path params to be interpolated in the generated URL.

  ## Examples
  ```
  Directions.url(:shop, :product_path, :new)
  # => "http://shop.com/products/new"

  Directions.url(:shop, :product_path, :show, id: 123)
  # => "http://shop.com/products/123"

  Directions.url(:shop, :product_path, :edit, id: 123)
  # => "http:shop.com/products/123/edit"
  ```
  """
  @spec url(group_name :: atom(), route_name :: atom(), action :: atom(), path_params :: keyword()) :: String.t()
  def url(group_name, route_name, action, path_params \\ []) do
    search_term = %SearchTerm{
      group_name: group_name,
      route_name: route_name,
      action: action,
      path_params: path_params
    }

    group = RoutesDB.group(group_name)

    Resolver.url(group, search_term)
  end
end
