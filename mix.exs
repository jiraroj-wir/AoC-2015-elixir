defmodule AOC2015.MixProject do
  use Mix.Project

  def project do
    [
      app: :AoC_2015,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "Advent of Code 2015 (Elixir)",
      description:
        "My solution on Advent of Code 2015 in Elixir, with test scripts and AI-generated story summaries.",
      source_url: "https://github.com/jiraroj-wir/AoC-2015-elixir",
      homepage_url: "https://github.com/jiraroj-wir/AoC-2015-elixir",
      package: package()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:jason, "~> 1.4"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  defp package do
    [
      licenses: ["Unlicense"],
      maintainers: ["jiraroj-wir"],
      links: %{
        "GitHub" => "https://github.com/jiraroj-wir/AoC-2015-elixir"
      }
    ]
  end
end
