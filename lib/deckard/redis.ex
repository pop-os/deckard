defmodule Deckard.Redis do
  @moduledoc """
  Handles Redis connection to get builds information.
  """

  def child_spec(args) do
    %{
      id: Deckard.Redis,
      start: {Deckard.Redis, :start_link, [args]}
    }
  end

  def start_link(opts) do
    Redix.start_link(opts)
  end

  def h_getall(key) do
    pid()
    |> Redix.command(["HGETALL", key])
    |> case do
      {:ok, value} -> {:ok, normalize(value)}
      {:error, error} -> error
    end
  end

  def pid do
    :deckard_builds
  end

  defp normalize(raw_data) do
    raw_data
    |> Enum.chunk_every(2)
    |> Map.new(fn [k, v] -> {k, v} end)
  end
end
