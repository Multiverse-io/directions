import Config

config :directions,
  route_sources: [
    {:shop_1, "http://shop_1.com", Path.expand("../test/support/shop_routes_1.txt", __DIR__)}
  ]
