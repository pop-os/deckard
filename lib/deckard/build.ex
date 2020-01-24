defmodule Deckard.Build do
  alias Deckard.Redis

  defstruct [:build, :channel, :release_date, :sha_sum, :size, :urgent, :url, :version]

  def last_urgent(channel) do
    with {:ok, versions} <- scan(channel) do
      Enum.find(versions, &urgent_build?(&1, channel))
    end
  end

  def find(version, channel) do
    version
    |> redis_key(channel)
    |> get(channel)
  end

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

  defp get(key, channel) do
    case Redis.query(["HGETALL", key]) do
      [] ->
        {:error, :not_found}

      raw_data ->
        data =
          raw_data
          |> Enum.chunk_every(2)
          |> Enum.into(%{}, fn [k, v] -> {k, v} end)

        try do
          release = %__MODULE__{
            build: data["build_version"],
            channel: channel,
            release_date: Map.get(data, "release_date", nil),
            sha_sum: data["sha_sum"],
            size: String.to_integer(data["byte_size"]),
            urgent: Map.get(data, "urgent", false),
            url: build_url(data["path"]),
            version: data["distro_version"]
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

  defp scan(channel, cursor \\ 0, matches \\ []) do
    with ["0", found] <- Redis.query(["SCAN", cursor, "MATCH", "*#{channel}"]) do
      {:ok, Enum.sort(found ++ matches, &(&1 >= &2))}
    else
      [cursor, found] -> scan(channel, cursor, found ++ matches)
      _ -> {:error, :unexpected_redis_error}
    end
  end

  defp urgent_build?(key, channel) do
    case get(key, channel) do
      {:ok, %{urgent: urgent}} ->
        urgent

      _ ->
        false
    end
  end
end
