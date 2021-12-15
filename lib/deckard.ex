defmodule Deckard do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @impl true
  def start(_type, _args) do
    redis_options = Application.get_env(:deckard, :redis_options, [])

    children = [
      Deckard.Endpoint,
      {Deckard.Redis, [{:name, Deckard.Redis.pid()} | redis_options]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Deckard.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    Deckard.Endpoint.config_change(changed, removed)
    :ok
  end
end
