defmodule Deckard.Shop do
  @moduledoc """
  Context to manage entities for the Pop!_Shop.
  """

  @doc """
  List featured packages on the top Pop!_Shop banner.
  """
  @spec get_projects() :: list(String.t())
  def get_projects do
    [
      "atom",
      "slack",
      "telegramdesktop",
      "meld",
      "org.gnome.Builder",
      "com.steampowered.steam",
      "mattermost-desktop",
      "code",
      "spotify",
      "com.gexperts.Tilix",
      "com.uploadedlobster.peek",
      "virt-manager",
      "signal-desktop",
      "cura",
      "chromium-browser"
    ]
  end

  @doc """
  List packages for Pop!_Shop recently updated carousel.
  """
  @spec get_releases() :: list()
  def get_releases, do: []

  @doc """
  List packages for Pop!_Shop trending carousel.
  """
  @spec get_downloads() :: list()
  def get_downloads, do: []
end
