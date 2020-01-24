defmodule Deckard.Mixfile do
  use Mix.Project

  def project do
    [
      app: :deckard,
      version: "0.1.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Deckard, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_), do: ["lib", "web"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # Runtime dependencies
      {:cors_plug, "~> 1.1"},
      {:cowboy, "~> 1.0"},
      {:exredis, ">= 0.2.4"},
      {:httpoison, "~> 0.13"},
      {:phoenix, "~> 1.3.2"},

      # Development and testing dependencies
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 0.5.0", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.14", only: :dev, runtime: false},
      {:mix_test_watch, "~> 0.3", only: :dev, runtime: false},

      # Deployment dependencies
      {:distillery, "~> 2.0.12"},
      {:edeliver, "~> 1.6.0"},
      {:toml, "~> 0.5.2"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      deploy: &deploy/1
    ]
  end

  defp deploy([env]) do
    Mix.Task.run("edeliver", ["upgrade", env])
    Mix.Task.reenable("edeliver")
    Mix.Task.run("edeliver", ["migrate", env])
  end
end
