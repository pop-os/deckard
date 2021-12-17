# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# Configures the Pop!_OS build info
config :deckard, Deckard.Releases.Build, url: "https://example-cdn.com"

config :deckard, Deckard.Releases.Storage, start_server: Mix.env() != :test

# Configures Redis connection
# For a full list of configuration options, please see:
# https://hexdocs.pm/redix/Redix.html#start_link/1-connection-options
config :deckard, Deckard.Releases.Storage.Redis,
  redis_options: [
    host: System.get_env("REDIS_HOST", "127.0.0.1"),
    port: System.get_env("REDIS_PORT", "6379") |> String.to_integer(),
    password: System.get_env("REDIS_PASSWORD", ""),
    database: 0
  ]

# Configures Elixir's Logger
config :logger,
  backends: [LoggerJSON]

config :logger_json, :backend,
  formatter: LoggerJSON.Formatters.DatadogLogger,
  metadata: :all

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
