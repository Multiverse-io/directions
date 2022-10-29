defmodule Directions.ResolverTest do
  use ExUnit.Case, async: true

  alias Directions.{Resolver, RoutesDB, SourcesLoader}

  setup_all do
    SourcesLoader.load()

    :ok
  end

  describe "run/3" do
    test "when given a valid group and route name, returns a URL" do
      group = RoutesDB.group(:shop_1)
      assert Resolver.url(group, :product_path) == "http://shop_1.com/products/new"
    end

    test "when given a valid group, route name and binding parameters returns a URL" do
      group = RoutesDB.group(:shop_1)

      assert Resolver.url(group, :live_dashboard_path, page: "foobar") ==
               "http://shop_1.com/dashboard/foobar"
    end
  end
end
