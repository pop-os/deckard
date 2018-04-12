defmodule Deckard.Redis do
  use GenServer

  ################
  # External API #
  ################

  def start_link(state \\ nil) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def query(cmd) do
    GenServer.call(__MODULE__, {:query, cmd})
  end

  ############################
  # GenServer Implementation #
  ############################

  def init(_state), do: Exredis.start_link

  def terminate(_reason, conn), do: Exredis.stop conn

  def handle_call({:query, cmd}, _from, conn) do
    res = Exredis.query(conn, cmd)

    {:reply, res, conn}
  end
end
