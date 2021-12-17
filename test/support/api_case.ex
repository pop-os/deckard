defmodule Deckard.Test.ApiCase do
  @moduledoc """
  This module defines utilities for HTTP Api tests.

  Such tests rely on `Plug.Test` and also
  imports other functionality to make it easier
  to build and query models.
  """
  import ExUnit.Assertions

  alias Plug.Conn

  use ExUnit.CaseTemplate

  using opts do
    quote bind_quoted: [opts: opts] do
      # Import conveniences for testing HTTP
      import Plug.Test
      import Deckard.Test.ApiCase
      import Deckard.Test.Fixtures

      alias Deckard.Api.Routes
    end
  end

  def assert_response(
        conn,
        exp_status,
        exp_body,
        exp_headers \\ [],
        decode_body_fn \\ fn x -> Jason.decode!(x) end
      ) do
    assert conn.status == exp_status
    assert decode_body_fn.(conn.resp_body) == exp_body

    for {name, value} <- exp_headers do
      clean_value = Conn.get_resp_header(conn, name)
      assert {name, clean_value} == {name, [value]}
    end
  end
end
