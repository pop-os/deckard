defmodule Deckard.Api.Routes do
  @moduledoc """
  Rest API routes for Deckard.
  """
  use Deckard.Api.Router

  alias Deckard.Releases
  alias Deckard.Shop

  get "/_health" do
    {:ok, version} = :application.get_key(:deckard, :vsn)

    send_json_resp(conn, 200, %{version: List.to_string(version)})
  end

  get "/builds/:version/:channel" do
    arch = Map.get(conn.query_params, "arch", "amd64")

    case Releases.find(version, arch, channel) do
      {:ok, build} ->
        send_json_resp(conn, 200, build)

      {:error, :not_found} ->
        send_json_resp(conn, 404)
    end
  end

  # TODO: houston v2 and deckard need to get a better URL naming scheme. This
  # is terrible.

  get "/shop/v1/newest/project" do
    send_json_resp(conn, 200, %{data: Shop.get_projects()})
  end

  get "/shop/v1/newest/release" do
    send_json_resp(conn, 200, %{data: Shop.get_releases()})
  end

  get "/shop/v1/newest/downloads" do
    send_json_resp(conn, 200, %{data: Shop.get_downloads()})
  end

  match _ do
    send_json_resp(conn, 404)
  end
end
