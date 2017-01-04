defmodule YamlFrontMatter.Mixfile do
  use Mix.Project

  def project do
    [app: :yaml_front_matter,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: "A YAML front matter parser for Elixir.",
     package: [
       name: :yaml_front_matter,
       files: ["lib", "priv", "mix.exs", "README*", "readme*", "LICENSE*", "license*"],
       maintainers: ["Sebastian De Deyne"],
       licenses: ["MIT"],
       links: %{"GitHub" => "https://github.com/sebastiandedeyne/yaml_front_matter"}],
     deps: [{:yaml_elixir, "~> 1.3"}]]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:yaml_elixir]]
  end
end
