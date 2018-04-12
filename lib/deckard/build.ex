defmodule Deckard.Build do
  alias Deckard.Redis

  defstruct [:channel, :version, :sha_sum, :size, :url]

  def find (channel) do
    case Redis.query(["HGETALL", redis_key(channel)]) do
      [] ->
        {:error, :not_found}

      raw_data ->
        data =
          raw_data
          |> Enum.chunk(2)
          |> Enum.into(%{}, fn [k, v] -> {k, v} end)

        try do
          release = %__MODULE__{
            channel: channel,
            version: String.to_integer(data["version"]),
            sha_sum: data["sha_sum"],
            size: String.to_integer(data["byte_size"]),
            url: build_url(channel, data["version"])
          }

          {:ok, release}
        rescue
          ArgumentError -> {:error, :invalid_data}
        end
    end
  end

  defp redis_key(nil), do: "pop_release"
  defp redis_key(channel), do: "pop_release:#{channel}"

  defp build_url(channel, version) do
    Application.get_env(:deckard, __MODULE__)[:url] <> "/#{channel}/#{version}/pop-os_amd64_#{channel}_#{version}.iso"
  end
end
