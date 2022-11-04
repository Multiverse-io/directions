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

      assert {:ok, "http://shop_1.com/products/new"} = Resolver.url(group, search_term)
    end

    test "when given a valid group, route name, action and path parameters returns a URL" do
      group = RoutesDB.group(:shop_1)

      search_term = %SearchTerm{
        group_name: :shop_1,
        route_name: :live_dashboard_path,
        action: :page,
        path_params: [page: "foobar", node: "fizz"]
      }

      assert {:ok, "http://shop_1.com/dashboard/fizz/foobar"} = Resolver.url(group, search_term)
    end

    test "returns the correct URL if path params are provided out of order" do
      group = RoutesDB.group(:shop_1)

      search_term = %SearchTerm{
        group_name: :shop_1,
        route_name: :live_dashboard_path,
        action: :page,
        path_params: [node: "fizz", page: "foobar"]
      }

      assert {:ok, "http://shop_1.com/dashboard/fizz/foobar"} = Resolver.url(group, search_term)

    end

    test "returns an error if the provided route name does not exist in the group" do
      group = RoutesDB.group(:shop_1)

      search_term = %SearchTerm{
        group_name: :shop_1,
        route_name: :wat_path,
        action: :index,
        path_params: []
      }

      assert {:error, :route_not_found, ^search_term} = Resolver.url(group, search_term)
    end

    test "returns an error if the provided action is not valid for the route" do
      group = RoutesDB.group(:shop_1)

      search_term = %SearchTerm{
        group_name: :shop_1,
        route_name: :product_path,
        action: :wrong,
        path_params: []
      }

      assert {:error, :route_not_found, ^search_term} = Resolver.url(group, search_term)
    end

    test "returns an error if the provided path params are incomplete" do
      group = RoutesDB.group(:shop_1)

      search_term = %SearchTerm{
        group_name: :shop_1,
        route_name: :products_path,
        action: :edit,
        path_params: []
      }

      assert {:error, :route_not_found, ^search_term} = Resolver.url(group, search_term)
    end
  end
end
