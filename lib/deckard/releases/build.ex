defmodule Deckard.Releases.Build do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [:channel, :build, :version, :sha_sum, :size, :url, :urgent]

  @type t :: %__MODULE__{}

  @spec new(String.t(), map()) :: {:ok, t()} | {:error, :invalid_data}
  def new(channel, data) do
    build = %__MODULE__{
      channel: channel,
      build: data["build_version"],
      version: data["distro_version"],
      sha_sum: data["sha_sum"],
      size: String.to_integer(data["byte_size"]),
      url: build_url(data["path"]),
      urgent: Map.get(data, "urgent", false)
    }

    {:ok, build}
  rescue
    ArgumentError -> {:error, :invalid_data}
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
end
