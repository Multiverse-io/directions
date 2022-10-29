defmodule Directions.SourcesLoader do
  alias Directions.{RoutesFileParser, RoutesDB}

  def load do
    Application.get_env(:directions, :route_sources, [])
    |> load()
  end

  def load(config) when is_list(config) do
    config
    |> Enum.reduce_while([], fn item, acc ->
      case item do
        {name, base_url, file_path} ->
          case File.read(file_path) do
            {:ok, contents} ->
              contents
              |> RoutesFileParser.parse()
              |> RoutesDB.store(name, base_url)

              {:cont, [item | acc]}

            {:error, :enoent} ->
              {:halt, {:error, :file_not_found, item}}
          end

        invalid_config ->
          {:halt, {:error, :invalid_source_config, invalid_config}}
      end
    end)
    |> parse_results()
  end

  defp parse_results({:error, _reason, _config} = error), do: error

  defp parse_results(configs) when is_list(configs), do: {:ok, configs}
end
