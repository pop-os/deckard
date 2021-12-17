use Mix.Config

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

###########################
# Development only config #
###########################

config :mix_test_watch,
  clear: true,
  tasks: ["test", "credo", "dialyzer"]
