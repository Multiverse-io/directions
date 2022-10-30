defmodule Directions.RoutesFileParser do
  @moduledoc false
  @route_regex ~r/\A\s*(?<route_name>[^\s]+)\s+GET\s+(?<path_pattern>[^\s]+)\s+(?<controller>[^\s]+)\s+(?<action>[^\s]+)\z/

  alias Directions.Route

  def parse(contents) do
    contents
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      Regex.named_captures(@route_regex, line)
    end)
    |> Enum.reject(&is_nil/1)
    |> Enum.map(&Route.from_map/1)
  end
end
