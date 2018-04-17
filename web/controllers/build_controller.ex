defmodule Deckard.BuildController do
  use Phoenix.Controller

  alias Deckard.Build

  def show(conn, %{"id" => channel}) do
    case Build.find(channel) do
      {:error, :not_found} ->
        conn
        |> send_resp(:not_found, "")
      {:error, _reason} ->
        conn
        |> send_resp(:internal_server_error, "")
      {:ok, build} ->
        conn
        |> put_resp_content_type("application/json")
        |> render(Deckard.BuildView, "show.json", build: build)
    end
  end
end
