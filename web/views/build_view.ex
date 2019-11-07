defmodule Deckard.BuildView do
  def render("show.json", %{build: build}) do
    %{
      channel: build.channel,
      build: build.build,
      version: build.version,
      sha_sum: build.sha_sum,
      size: build.size,
      url: build.url,
      urgent: build.urgent
    }
  end
end
