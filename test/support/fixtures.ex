defmodule Deckard.Test.Fixtures do
  @moduledoc """
  Common test fixtures.
  """

  def valid_build_fixture(version, channel, arch) do
    %{
      "channel" => channel,
      "build_version" => version,
      "distro_version" => version,
      "sha_sum" => "fooo",
      "byte_size" => "204800",
      "path" => "releases/pop_test_#{channel}_#{arch}-#{version}.iso"
    }
  end
end
