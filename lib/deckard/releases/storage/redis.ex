defmodule Deckard.Releases.Storage.Redis do
  @moduledoc """
  Redis backed Storage for Releases.
  """

  @behaviour Deckard.Releases.Storage

  @impl true
  def start_link(_opts) do
    redis_options =
      :deckard
      |> Application.get_env(__MODULE__, [])
      |> Keyword.get(:redis_options, [])

    Redix.start_link(Keyword.merge([{:name, __MODULE__.process_name()}], redis_options))
  end

  @impl true
  def get_build(version, arch, channel) do
    process_name()
    |> Redix.command(["HGETALL", redis_key(version, arch, channel)])
    |> case do
      {:ok, []} -> {:error, :not_found}
      {:ok, value} -> {:ok, normalize(value)}
      error -> error
    end
  end

  @impl true
  def process_name do
    :deckard_builds
  end

  defp redis_key("17.10", _arch, channel), do: "pop_release:#{channel}"
  defp redis_key(version, arch, channel), do: "pop_release:#{version}_#{arch}_#{channel}"

  defp normalize(raw_data) do
    raw_data
    |> Enum.chunk_every(2)
    |> Map.new(fn [k, v] -> {k, v} end)
  end
end
