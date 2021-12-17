use Mix.Config

config :deckard, Deckard.Releases.Storage, implementation: RedisMock

# Print only warnings and errors during test
config :logger, level: :warn
