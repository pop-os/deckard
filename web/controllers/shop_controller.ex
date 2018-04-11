defmodule Deckard.ShopController do
  use Phoenix.Controller

  def projects(conn, _params) do
    render conn, Deckard.ShopView, "projects.json"
  end

  def releases(conn, _params) do
    render conn, Deckard.ShopView, "releases.json"
  end

  def downloads(conn, _params) do
    render conn, Deckard.ShopView, "downloads.json"
  end
end
