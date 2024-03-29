defmodule Deckard.Build do
  alias Deckard.Redis

  defstruct [:channel, :build, :version, :sha_sum, :size, :url, :urgent]

  def find(version, arch, channel) do
    case Redis.query(["HGETALL", redis_key(version, arch, channel)]) do
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
            url: build_url(data["path"]),
            urgent: Map.get(data, "urgent", false)
          }

          {:ok, release}
        rescue
          ArgumentError -> {:error, :invalid_data}
        end
    end
  end

  defp redis_key("17.10", _arch, channel), do: "pop_release:#{channel}"
  defp redis_key(version, arch, channel), do: "pop_release:#{version}_#{arch}_#{channel}"

  defp build_url(path) do
    root_url =
      :deckard
      |> Application.get_env(__MODULE__)
      |> Keyword.get(:url, "")
      |> String.trim()
      |> String.trim("/")

    # Past versions were stored in a nested folder. When we moved ISOs to their
    # own bucket, we made it top level.
    file_path =
      path
      |> String.trim()
      |> String.trim("/")
      |> String.replace_prefix("pop-os/iso/", "")

    root_url <> "/" <> file_path
  end
end
