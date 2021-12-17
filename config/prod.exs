use Mix.Config

# Do not print debug messages in production
config :logger, level: :info

# Finally import the config/prod.secret.exs
# which should be versioned separately.
try do
  import_config "prod.secret.exs"
rescue
  Code.LoadError ->
    # Conform will fill these at runtime
    :no_op
end
