defmodule Deckard.Api.Supervisor do
  @moduledoc false

  use Supervisor

  require Logger

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, [name: __MODULE__] ++ opts)
  end

  def init(:ok) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: Deckard.Api.Routes, options: [port: port()]}
    ]

    Logger.info("Starting Deckard API on #{port()}...")

    Supervisor.init(children, strategy: :one_for_one)
  end

  defp port do
    :deckard
    |> Application.get_env(Deckard.Api, port: 4000)
    |> Keyword.get(:port)
  end
end
