defmodule MrT.Mixfile do
  use Mix.Project

  def project do
    [app: :mr_t,
     version: "0.5.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     description: "Fastest TDD package for Elixir",
     source_url: "https://github.com/ruby2elixir/mr_t",
     package: package]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [ mod: { MrT, [] },
      applications: [:exfswatch, :logger],
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [ {:exfswatch, "~> 0.2.1"} ]
  end

  defp package do
    %{
        maintainers: ["Roman Heinrich"],
        licenses: ["MIT License"],
        links: %{"Github" => "https://github.com/ruby2elixir/mr_t"}
     }
  end
end
