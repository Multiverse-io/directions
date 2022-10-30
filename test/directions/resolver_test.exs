defmodule Directions.ResolverTest do
  use ExUnit.Case, async: true

  alias Directions.{Resolver, RoutesDB, SearchTerm, SourcesLoader}

  setup_all do
    SourcesLoader.load()

    :ok
  end

  describe "run/3" do
    test "when given a valid group, route name and action, returns a URL" do
      group = RoutesDB.group(:shop_1)

      search_term = %SearchTerm{
        group_name: :shop_1,
        route_name: :product_path,
        action: :new,
        path_params: []
      }

      assert Resolver.url(group, search_term) == "http://shop_1.com/products/new"
    end

    test "when given a valid group, route name, action and path parameters returns a URL" do
      group = RoutesDB.group(:shop_1)

      search_term = %SearchTerm{
        group_name: :shop_1,
        route_name: :live_dashboard_path,
        action: :page,
        path_params: [page: "foobar", node: "fizz"]
      }

      assert Resolver.url(group, search_term) ==
               "http://shop_1.com/dashboard/fizz/foobar"
    end

    test "returns the correct URL if path params are provided out of order" do
      group = RoutesDB.group(:shop_1)

      search_term = %SearchTerm{
        group_name: :shop_1,
        route_name: :live_dashboard_path,
        action: :page,
        path_params: [node: "fizz", page: "foobar"]
      }

      assert Resolver.url(group, search_term) ==
               "http://shop_1.com/dashboard/fizz/foobar"
    end
  end
end
