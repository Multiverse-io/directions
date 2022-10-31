# Directions

[![Build Status](https://github.com/Multiverse-io/directions/actions/workflows/ci.yml/badge.svg)](https://github.com/Multiverse-io/directions/actions)

Directions is a small Elixir library aimed at generating URLs that point to a Phoenix application.

The primary use case is when there are different Phoenix web applications that need to display HTML links pointing to each other.

Imagine for example two applications, A and B. If we wanted to display an HTML link in A that points to a route in B, without Directions we would need to hardcode that URL path, including any path params. Directions ensures that only valid URLs can be generated, which is done by configuring application A to read a file containing the output of running `mix phx.routes` in application B.

## Example

In the target application, run `mix phx.routes [RouterModule] > /path/to/output.txt`. Then configure your application to load that file:

```elixir
# Multiple different route files can be provided in the config below
config :directions,
  route_sources: [
    {:shop, "http://shop.com", Path.expand("../shared_routes/shop_routes.txt", __DIR__)}
  ]
```

The above will read that file and keep it in the library's state. Now, whenever your application needs to generate a link pointing to the external Phoenix web app, use something like:

```
# This will generate a URL like http://shop.com/products/123
<%= link "A Great Product!", to: Directions.url(:shop, :product_path, :show, id: 123)
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `directions` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:directions, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/directions>.

