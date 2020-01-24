defmodule Deckard.BuildController do
  use Phoenix.Controller

  alias Deckard.Build

  def show(conn, %{"version" => version, "channel" => channel}) do
    with {:ok, build} <- Build.find(version, channel),
         {:ok, last_urgent_build} <- Build.last_urgent(channel) do
      conn
      |> put_resp_content_type("application/json")
      |> render(Deckard.BuildView, "show.json", build: build, last_urgent_build: last_urgent_build)
    else
      {:error, :not_found} ->
        send_resp(conn, :not_found, "")

      {:error, _reason} ->
        send_resp(conn, :internal_server_error, "")
    end
  end
end
