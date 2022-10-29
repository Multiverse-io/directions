defmodule DirectionsTest do
  use ExUnit.Case, async: true

  alias Directions.SourcesLoader

  setup_all do
    SourcesLoader.load()

    :ok
  end

  describe "url/3" do
    test "when given a valid group and route name, returns a URL" do
      assert Directions.url(:shop_1, :product_path) == "http://shop_1.com/products/new"
    end
  end
end
