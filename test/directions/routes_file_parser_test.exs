defmodule Directions.RoutesFileParserTest do
  use ExUnit.Case, async: true

  alias Directions.{Route, RoutesFileParser}

  test "parses a routes file ignoring all the non-GET routes" do
    contents =
      Path.expand("../support/shop_routes_1.txt", __DIR__)
      |> File.read!()

    routes = RoutesFileParser.parse(contents)

    assert length(routes) == 16

    assert %Route{
             action: ":index",
             controller: "ShopWeb.PageController",
             path_pattern: "/",
             route_name: "page_path",
             path_params: []
           } == List.first(routes)

    Enum.each(routes, fn route ->
      assert route.action
      assert route.controller
      assert route.path_pattern
      assert route.route_name
    end)
  end
end
