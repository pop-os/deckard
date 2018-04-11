defmodule Deckard.ShopControllerTest do
  use Deckard.ConnCase

  test "returns an array of data for projects", %{conn: conn} do
    conn = get conn, "/newest/project"

    assert json_response(conn, 200)["data"] |> is_list
  end

  test "returns an array of data for releases", %{conn: conn} do
    conn = get conn, "/newest/release"

    assert json_response(conn, 200)["data"] |> is_list
  end

  test "returns an array of data for downloads", %{conn: conn} do
    conn = get conn, "/newest/downloads"

    assert json_response(conn, 200)["data"] |> is_list
  end
end
