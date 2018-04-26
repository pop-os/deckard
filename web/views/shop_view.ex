defmodule Deckard.ShopView do
  def render("projects.json", _assigns) do
    %{
      data: [
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
    }
  end

  def render("releases.json", _assigns) do
    %{
      data: [
      ]
    }
  end

  def render("downloads.json", _assigns) do
    %{
      data: [
      ]
    }
  end
end
