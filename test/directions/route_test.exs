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
               route_name: "foo_bar_path",
               path_params: []
             }
    end

    test "finds path params in the provided path pattern" do
      map = %{
        "action" => "foo",
        "controller" => "bar",
        "path_pattern" => "/foo/:bar/fizz/:buzz/edit",
        "route_name" => "foo_bar_path"
      }

      assert Route.from_map(map) == %Route{
               action: "foo",
               controller: "bar",
               path_pattern: "/foo/:bar/fizz/:buzz/edit",
               route_name: "foo_bar_path",
               path_params: [":bar", ":buzz"]
             }
    end

    test "finds path params in the provided path pattern when there is a path param at the end of the path" do
      map = %{
        "action" => "foo",
        "controller" => "bar",
        "path_pattern" => "/foo/:wat/fizz/:buzz/edit/:bar",
        "route_name" => "foo_bar_path"
      }

      assert Route.from_map(map) == %Route{
               action: "foo",
               controller: "bar",
               path_pattern: "/foo/:wat/fizz/:buzz/edit/:bar",
               route_name: "foo_bar_path",
               path_params: [":bar", ":buzz", ":wat"]
             }
    end
  end

  describe "apply_path_params/2" do
    test "when given empty path params, returns the path pattern" do
      route = %Route{
        action: "foo",
        controller: "bar",
        path_pattern: "/foo/:bar/fizz/:buzz/edit",
        route_name: "foo_bar_path",
        path_params: [":bar", ":buzz"]
      }

      assert Route.apply_path_params(route, []) == "/foo/:bar/fizz/:buzz/edit"
    end

    test "interpolates a single path param into the path pattern" do
      route = %Route{
        action: "foo",
        controller: "bar",
        path_pattern: "/foo/:bar/fizz/:buzz/edit",
        route_name: "foo_bar_path",
        path_params: [":bar", ":buzz"]
      }

      assert Route.apply_path_params(route, bar: "haha", buzz: "hehe") ==
               "/foo/haha/fizz/hehe/edit"
    end

    test "can interpolate path params when those are given as numbers" do
      route = %Route{
        action: "foo",
        controller: "bar",
        path_pattern: "/foo/:bar/fizz/:buzz/edit",
        route_name: "foo_bar_path",
        path_params: [":bar", ":buzz"]
      }

      assert Route.apply_path_params(route, bar: 10, buzz: 20) == "/foo/10/fizz/20/edit"
    end
  end
end
