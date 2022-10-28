defmodule Directions.RouteTest do
  use ExUnit.Case, async: true

  alias Directions.Route

  describe "from_map/1" do
    test "converts a map with string keys into a struct" do
      map = %{
        "action" => "foo",
        "controller" => "bar",
        "path_pattern" => "/foo/bar",
        "route_name" => "foo_bar_path"
      }

      assert Route.from_map(map) == %Route{
        action: "foo",
        controller: "bar",
        path_pattern: "/foo/bar",
        route_name: "foo_bar_path"
      }
    end
  end
end
