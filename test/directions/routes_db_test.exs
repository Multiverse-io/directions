defmodule Directions.RoutesDbTest do
  use ExUnit.Case, async: true

  alias Directions.{Route, RoutesDB, RouteGroup}

  describe "store/3" do
    test "stores the routes" do
      route = %Route{
        route_name: "foo_bar_path",
        path_pattern: "/foobar",
        action: "bar",
        controller: "foo",
        path_params: []
      }

      RoutesDB.store(
        [route],
        :my_app,
        "http://my.app"
      )

      assert RoutesDB.group(:my_app) == %RouteGroup{
               name: :my_app,
               base_url: "http://my.app",
               routes: %{"foo_bar_pathbar" => route}
             }
    end
  end
end
