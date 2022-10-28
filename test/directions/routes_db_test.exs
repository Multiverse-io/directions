defmodule Directions.RoutesDbTest do
  use ExUnit.Case, async: true

  alias Directions.RoutesDB

  describe "store/3" do
    test "stores the routes" do
      RoutesDB.store(
        [%{"route_name" => "foo_bar_path", "path_pattern" => "/foobar"}],
        :my_app,
        "http://my.app"
      )

      assert RoutesDB.group(:my_app) == %{
               base_url: "http://my.app",
               routes: [%{"path_pattern" => "/foobar", "route_name" => "foo_bar_path"}]
             }
    end
  end
end
