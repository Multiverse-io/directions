defmodule Directions do
  @moduledoc """
  Directions is a small Elixir library aimed at generating URLs that point to a Phoenix application.

  The primary use case is when there are different Phoenix web applications that need to display HTML links pointing to each other.

  Imagine for example two applications, A and B. If we wanted to display an HTML link in A that points to a route in B, without Directions we would need to hardcode that URL path, including any path params. Directions ensures that only valid URLs can be generated, which is done by configuring application A to read a file containing the output of running `mix phx.routes` in application B.

  ## Example

  In the target application, run `mix phx.routes [RouterModule] > /path/to/output.txt`. Then configure your application to load that file:

        # Multiple different route files can be provided in the config below
        config :directions,
          route_sources: [
            {:shop, "http://shop.com", Path.expand("../shared_routes/shop_routes.txt", __DIR__)}
          ]

  The above will read that file and keep it in the library's state. Now, whenever your application needs to generate a link pointing to the external Phoenix web app, use something like:

        # This will generate a URL like http://shop.com/products/123
        <%= link "A Great Product!", to: Directions.url(:shop, :product_path, :show, id: 123)
  """

  alias Directions.{Resolver, RoutesDB, SearchTerm}

  defmodule GroupNotFoundError do
    defexception [:message]

    @impl true
    def exception(group_name) do
      %__MODULE__{message: "Could not find a routes group named #{group_name}"}
    end
  end

  defmodule RouteNotFoundError do
    defexception [:message]

    @impl true
    def exception(search_term) do
      %__MODULE__{message: "Could not find a route with the provided search terms: #{inspect(search_term)}"}
    end
  end

  @doc """
  Generates a URL

  ## Arguments:

  - `group_name`: The name of the routes group, as defined in the library configuration for each
    of the loaded routes files.
  - `route_name`: The name of route, matching one of the routes listed within the route file
  - `action`: The name of the action for the given route
  - `path_params`: Keyword list with the path params to be interpolated in the generated URL.

  ## Examples

        Directions.url(:shop, :product_path, :new)
        # => "http://shop.com/products/new"

        Directions.url(:shop, :product_path, :show, id: 123)
        # => "http://shop.com/products/123"

        Directions.url(:shop, :product_path, :edit, id: 123)
        # => "http:shop.com/products/123/edit"
  """
  @spec url(group_name :: atom(), route_name :: atom(), action :: atom(), path_params :: keyword()) :: {:ok, String.t()} | {:error, atom(), %Directions.SearchTerm{}}
  def url(group_name, route_name, action, path_params \\ []) do
    search_term = %SearchTerm{
      group_name: group_name,
      route_name: route_name,
      action: action,
      path_params: path_params
    }

    group = RoutesDB.group(group_name)

    if group do
      Resolver.url(group, search_term)
    else
      {:error, :routes_group_not_found, search_term}
    end
  end

  @doc """
  Similar to Directions.url/4 but returns the generated URL or raises an error if there's no group with
  that name or if a route can't be found with the provided arguments.
  """
  @spec url!(group_name :: atom(), route_name :: atom(), action :: atom(), path_params :: keyword()) :: String.t()
  def url!(group_name, route_name, action, path_params \\ []) do
    case url(group_name, route_name, action, path_params) do
      {:ok, url} -> url
      {:error, :routes_group_not_found, %SearchTerm{}} -> raise GroupNotFoundError, group_name
      {:error, :route_not_found, search_term} -> raise RouteNotFoundError, search_term
    end
  end
end
