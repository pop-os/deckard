defmodule Deckard.Api.RoutesTest do
  @moduledoc false
  use Deckard.Test.ApiCase, async: true
  import Mox

  # Make sure mocks are verified when the test exits
  setup :verify_on_exit!

  describe "GET /builds/:version/:channel" do
    test "returns 500 error if an unhandled message is returned from Storage" do
      RedisMock
      |> expect(:get_build, fn _version, _arch, _channel -> :boom_dude end)

      expected_response = %{"errors" => ["Internal Server Error"]}
      conn = conn(:get, "/builds/10.04/raspi")

      # Assert error is thrown and logged but 500 response shown to the user
      assert_raise Plug.Conn.WrapperError,
                   "** (CaseClauseError) no case clause matching: :boom_dude",
                   fn -> Routes.call(conn, []) end

      assert_received {:plug_conn, :sent}
      assert {500, _headers, response} = sent_resp(conn)
      assert Jason.decode!(response) == expected_response
    end

    test "returns 404 error if {:error, :not_found} is returned from Storage" do
      RedisMock
      |> expect(:get_build, fn _version, _arch, _channel -> {:error, :not_found} end)

      :get
      |> conn("/builds/10.04/raspi")
      |> Routes.call([])
      |> assert_response(404, %{"errors" => ["Not Found"]})
    end

    test "defaults arch to amd64 if none is provided as query param" do
      RedisMock
      |> expect(:get_build, fn version, "amd64" = arch, channel ->
        {:ok, valid_build_fixture(version, channel, arch)}
      end)

      expected_data = %{
        "build" => "10.04",
        "channel" => "intel",
        "sha_sum" => "fooo",
        "size" => 204_800,
        "urgent" => false,
        "url" => "https://example-cdn.com/releases/pop_test_intel_amd64-10.04.iso",
        "version" => "10.04"
      }

      :get
      |> conn("/builds/10.04/intel")
      |> Routes.call([])
      |> assert_response(200, expected_data)
    end

    test "queries right arch if provided as query param" do
      RedisMock
      |> expect(:get_build, fn version, "arm64" = arch, channel ->
        {:ok, valid_build_fixture(version, channel, arch)}
      end)

      expected_data = %{
        "build" => "10.04",
        "channel" => "raspi",
        "sha_sum" => "fooo",
        "size" => 204_800,
        "urgent" => false,
        "url" => "https://example-cdn.com/releases/pop_test_raspi_arm64-10.04.iso",
        "version" => "10.04"
      }

      :get
      |> conn("/builds/10.04/raspi?arch=arm64")
      |> Routes.call([])
      |> assert_response(200, expected_data)
    end
  end

  describe "GET /shop/v1/newest/release" do
    test "returns an array of data for releases" do
      :get
      |> conn("/shop/v1/newest/release")
      |> Routes.call([])
      |> assert_response(200, %{"data" => []})
    end
  end

  describe "GET /shop/v1/newest/downloads" do
    test "returns an array of data for downloads" do
      :get
      |> conn("/shop/v1/newest/downloads")
      |> Routes.call([])
      |> assert_response(200, %{"data" => []})
    end
  end

  describe "GET /_health" do
    version = Application.spec(:deckard, :vsn) |> List.to_string()

    :get
    |> conn("/_health")
    |> Routes.call([])
    |> assert_response(200, %{"version" => version})
  end

  describe "API Error handling" do
    test "renders 404 for unknown endpoints" do
      :get
      |> conn("/shop/fakeurl")
      |> Routes.call([])
      |> assert_response(404, %{"errors" => ["Not Found"]})
    end
  end
end
