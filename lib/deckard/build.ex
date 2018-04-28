defmodule Deckard.Build do
  alias Deckard.Redis

  defstruct [:channel, :build, :version, :sha_sum, :size, :url]

  def find(version, channel) do
    case Redis.query(["HGETALL", redis_key(version, channel)]) do
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
            build: data["build_version"],
            version: data["distro_version"],
            sha_sum: data["sha_sum"],
            size: String.to_integer(data["byte_size"]),
            url: build_url(data["path"])
          }

          {:ok, release}
        rescue
          ArgumentError -> {:error, :invalid_data}
        end
    end
  end

  defp redis_key(version, channel) do
    if version == "17.10" do
      "pop_release:#{channel}"
    else
      "pop_release:#{version}_amd64_#{channel}"
    end
  end

  defp build_url(path) do
    Application.get_env(:deckard, __MODULE__)[:url] <> "/" <> path
  end
end
