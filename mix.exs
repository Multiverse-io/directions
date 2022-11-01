defmodule Directions.MixProject do
  use Mix.Project

  @scm_url "https://github.com/Multiverse-io/directions"
  @version "0.0.1"

  def project do
    [
      app: :directions,
      version: @version,
      elixir: "~> 1.11",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      package: package(),
      deps: deps(),
      source_url: @scm_url,
      description: """
      Helper to create and validate URLs based on an Phoenix web app's routes.
      """,
      docs: docs()
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test"]
  defp elixirc_paths(_), do: ["lib"]

  def application do
    [
      extra_applications: [:logger],
      mod: {Directions.Application, []}
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.27", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      links: %{"GitHub" => @scm_url},
      licenses: ["MIT"],
      maintainers: ["Cássio Marques"],
      files: ~w(lib config mix.exs README.md LICENSE.md)
    ]
  end

  defp docs do
    [
      main: "Directions",
      source_ref: "v#{@version}",
      canonical: "https://hexdocs.pm/directions",
      source_url: @scm_url
    ]
  end
end
