defmodule YamlFrontMatter.Mixfile do
  use Mix.Project

  @version "1.0.0"

  def project do
    [
      app: :yaml_front_matter,
      version: @version,
      elixir: "~> 1.4",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: "A YAML front matter parser for Elixir.",
      package: package(),
      deps: deps(),
      docs: [
        extras: ["README.md"],
        main: "readme",
        source_ref: "v#{@version}",
        source_url: "https://github.com/sebastiandedeyne/yaml_front_matter"
      ]
    ]
  end

  def application do
    [applications: [:yaml_elixir]]
  end

  defp package do
    [
      name: :yaml_front_matter,
      files: ["lib", "mix.exs", "README.md", "LICENSE.md"],
      maintainers: ["Sebastian De Deyne"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/sebastiandedeyne/yaml_front_matter"}
    ]
  end

  defp deps do
    [{:yaml_elixir, "~> 2.0"}, {:ex_doc, ">= 0.0.0", only: :dev}]
  end
end
