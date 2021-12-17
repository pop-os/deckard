defmodule Deckard.Application do
  @moduledoc false

  use Application

  alias Deckard.Releases.Storage

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @impl true
  def start(_type, _args) do
    children = [
      Deckard.Api.Supervisor,
      Storage
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Deckard.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
