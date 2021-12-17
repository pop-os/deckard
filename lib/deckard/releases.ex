defmodule Deckard.Releases do
  @moduledoc """
  Context module to handle Pop_OS! Releases.
  """
  alias Deckard.Releases.Build
  alias Deckard.Releases.Storage

  @doc """
  Show details of an specific Pop_OS! release.
  """
  @spec find(Version.version(), String.t(), String.t()) :: {:ok, Build.t()} | {:error, any()}
  def find(version, arch, channel) do
    with {:ok, data} <- Storage.get_build(version, arch, channel) do
      Build.new(channel, data)
    end
  end
end
