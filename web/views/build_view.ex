defmodule Deckard.BuildView do
  def render("show.json", %{build: build, last_urgent_build: last_urgent_build}) do
    %{
      build: build.build,
      channel: build.channel,
      last_release_date: last_release_date(last_urgent_build),
      sha_sum: build.sha_sum,
      size: build.size,
      urgent: build.urgent,
      url: build.url,
      version: build.version
    }
  end

  defp last_release_date(%{release_date: release_date}), do: release_date
  defp last_release_date(_), do: nil
end
