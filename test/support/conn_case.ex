defmodule Deckard.ConnCase do
  @moduledoc """
  This module defines a test that requires a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  imports other functionality to make it easier
  to build and query models.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest

      import Deckard.Router.Helpers
      import Deckard.ConnCase

      # The default endpoint for testing
      @endpoint Deckard.Endpoint
    end
  end

  @dialyzer {:no_return, __ex_unit_setup_0: 1}
  setup do
    conn =
      Phoenix.ConnTest.build_conn()
      |> Plug.Conn.put_req_header("accept", "application/json")

    {:ok, conn: conn}
  end
end
