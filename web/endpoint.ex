defmodule Deckard.Endpoint do
  use Phoenix.Endpoint, otp_app: :deckard

  if code_reloading? do
    plug Phoenix.CodeReloader
  end

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.Logger
  plug CORSPlug

  plug Deckard.Router
end
