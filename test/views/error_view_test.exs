defmodule Deckard.ErrorViewTest do
  use Deckard.ConnCase, async: true

  import Phoenix.View

  test "renders 404.json" do
    assert render_to_string(Deckard.ErrorView, "404.json", []) ==
             ~s({"errors":[{"title":"Resource not found"}]})
  end

  test "render 500.json" do
    assert render_to_string(Deckard.ErrorView, "500.json", []) ==
             ~s({"errors":[{"title":"Server internal error"}]})
  end

  test "render any other" do
    assert render_to_string(Deckard.ErrorView, "505.json", []) ==
             ~s({"errors":[{"title":"Server internal error"}]})
  end
end
