defmodule Directions.SourcesLoaderTest do
  use ExUnit.Case, async: true

  alias Directions.{RoutesDB, SourcesLoader}

  describe "load/0" do
    test "loads the routes using the application config" do
      assert {:ok, _} = SourcesLoader.load()

      assert %{
               base_url: "http://shop_1.com",
               routes: %{}
             } = RoutesDB.groups()[:shop_1]

      routes_count =
        RoutesDB.groups()[:shop_1]
        |> Map.get(:routes)
        |> Map.keys()
        |> length()

      assert routes_count == 10
    end
  end

  describe "load/1" do
    test "succeeds if the config is empty" do
      assert {:ok, []} == SourcesLoader.load([])
    end

    test "succeeds if the config is not empty and all entries are valid" do
      config = [
        {:shop_1, "http://shop_1.com", Path.expand("../support/shop_routes_1.txt", __DIR__)}
      ]

      assert {:ok, _} = SourcesLoader.load(config)

      assert %{
               base_url: "http://shop_1.com",
               routes: %{}
             } = RoutesDB.groups()[:shop_1]

      routes_count =
        RoutesDB.groups()[:shop_1]
        |> Map.get(:routes)
        |> Map.keys()
        |> length()

      assert routes_count == 10
    end

    test "fails if one of the entries does not contain the group name" do
      source_config_1 =
        {:shop_1, "http://shop_1.com", Path.expand("../support/shop_routes_1.txt", __DIR__)}

      source_config_2 =
        {"http://shop_2.com", Path.expand("../support/shop_routes_2.txt", __DIR__)}

      config = [source_config_1, source_config_2]

      assert {:error, :invalid_source_config, ^source_config_2} = SourcesLoader.load(config)
    end

    test "fails if one of the entries does not contain a base url" do
      source_config_1 =
        {:shop_1, "http://shop_1.com", Path.expand("../support/shop_routes_1.txt", __DIR__)}

      source_config_2 = {:shop_2, Path.expand("../support/shop_routes_2.txt", __DIR__)}

      config = [source_config_1, source_config_2]

      assert {:error, :invalid_source_config, ^source_config_2} = SourcesLoader.load(config)
    end

    test "fails if one of the entries does not contain the path to the routes file" do
      source_config_1 =
        {:shop_1, "http://shop_1.com", Path.expand("../support/shop_routes_1.txt", __DIR__)}

      source_config_2 = {:shop_2, "http://shop_2.com"}

      config = [source_config_1, source_config_2]

      assert {:error, :invalid_source_config, ^source_config_2} = SourcesLoader.load(config)
    end

    test "fails if the route file can't be found" do
      source_config_1 =
        {:shop_1, "http://shop_1.com", Path.expand("../support/shop_routes_1.txt", __DIR__)}

      source_config_2 =
        {:shop_2, "http://shop_2.com", Path.expand("../support/wrong.txt", __DIR__)}

      config = [source_config_1, source_config_2]

      assert {:error, :file_not_found, ^source_config_2} = SourcesLoader.load(config)
    end
  end
end
