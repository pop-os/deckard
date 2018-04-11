defmodule Deckard.ShopView do
  def render("projects.json", _assigns) do
    %{
      data: [
        "chromium-browser",
        "meld",
        "telegramdesktop",
        "org.gnome.Builder",
        "steam",
        "virtualbox",
        "virt-manager",
        "glade",
        "vlc",
        "org.kde.krita",
        "gimp",
        "inkscape",
        "keepassx",
        "scribus"
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
