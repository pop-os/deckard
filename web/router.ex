defmodule Deckard.Router do
  use Phoenix.Router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Deckard do
    pipe_through :api

    get "/builds/:version/:channel", BuildController, :show

    # TODO: houston v2 and deckard need to get a better URL naming scheme. This
    # is terrible.

    # The top Pop!_Shop banner
    get "/shop/v1/newest/project", ShopController, :projects

    # The Pop!_Shop recently updated carousel
    get "/shop/v1/newest/release", ShopController, :releases

    # This is the Pop!_Shop trending carousel
    get "/shop/v1/newest/downloads", ShopController, :downloads
  end
end
