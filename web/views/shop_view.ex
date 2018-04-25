defmodule Deckard.ShopView do
  def render("projects.json", _assigns) do
    %{
      data: [
        "telegramdesktop",
        "meld",
        "org.gnome.Builder",
        "com.gexperts.Tilix",
        "virt-manager"
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
