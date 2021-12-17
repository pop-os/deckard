defmodule Deckard.Releases.Storage do
  @moduledoc """
  Behaviour for handling build storage.
  """

  @callback start_link(binary | keyword) :: {:ok, pid()} | :ignore | {:error, term()}

  @callback get_build(Version.version(), String.t(), String.t()) ::
              {:ok, Enum.t()} | {:error, any()}

  @callback process_name() :: atom()

  def child_spec(args) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [args]}
    }
  end

  def start_link(opts) do
    if Keyword.get(config(), :start_server, true) do
      implementation().start_link(opts)
    else
      {:ok, self()}
    end
  end

  @spec get_build(Version.version(), String.t(), String.t()) :: {:ok, Enum.t()} | {:error, any()}
  def get_build(version, arch, channel), do: implementation().get_build(version, arch, channel)

  @spec process_name() :: atom()
  def process_name, do: implementation().process_name()

  defp implementation do
    Keyword.get(config(), :implementation, Deckard.Releases.Storage.Redis)
  end

  defp config do
    :deckard
    |> Application.get_env(__MODULE__, [])
  end
end
