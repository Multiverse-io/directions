defmodule DirectionsTest do
  use ExUnit.Case, async: true

  alias Directions.SourcesLoader

  setup_all do
    SourcesLoader.load()

    :ok
  end

  describe "url/3" do
    test "when given a valid group and route name, returns a URL" do
      assert {:ok, "http://shop_1.com/products/new"} = Directions.url(:shop_1, :product_path, :new)
    end

    test "when given invalid arguments, returns an error" do
      assert {:error, :route_not_found, %Directions.SearchTerm{}} = Directions.url(:shop_1, :foo_path, :new)
    end

    test "when given an invalif group name, returns an error" do
      assert {:error, :routes_group_not_found, %Directions.SearchTerm{}} = Directions.url(:wat, :foo_path, :new)
    end
  end

  describe "url!/3" do
    test "when given a valid group and route name, returns a URL" do
      assert "http://shop_1.com/products/new" == Directions.url!(:shop_1, :product_path, :new)
    end

    test "when given invalid arguments, returns an error" do
      assert_raise(Directions.RouteNotFoundError, fn ->
        Directions.url!(:shop_1, :foo_path, :mew)
      end)
    end

    test "when given an invalid group name, returns an error" do
      assert_raise(Directions.GroupNotFoundError, fn ->
        Directions.url!(:wat, :foo_path, :mew)
      end)
    end
  end
end
