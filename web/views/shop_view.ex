defmodule Deckard.ShopView do
  def render("projects.json", _assigns) do
    %{
      data: [
        "com.github.cassidyjames.palette",
        "com.github.plugarut.pwned-checker",
        "com.github.artemanufrij.findfileconflicts",
        "com.github.santileortiz.iconoscope",
        "com.github.bleakgrey.transporter",
        "com.github.bartzaalberg.alias",
        "com.github.artemanufrij.graphui",
        "com.github.peteruithoven.resizer",
        "com.github.bartzaalberg.snaptastic",
        "com.github.cjfloss.envelope"
      ]
    }
  end

  def render("releases.json", _assigns) do
    %{
      data: [
        "com.github.cassidyjames.palette",
        "com.github.plugarut.pwned-checker",
        "com.github.artemanufrij.findfileconflicts",
        "com.github.santileortiz.iconoscope",
        "com.github.bleakgrey.transporter",
        "com.github.bartzaalberg.alias",
        "com.github.artemanufrij.graphui",
        "com.github.peteruithoven.resizer",
        "com.github.bartzaalberg.snaptastic",
        "com.github.cjfloss.envelope"
      ]
    }
  end

  def render("downloads.json", _assigns) do
    %{
      data: [
        "com.github.cassidyjames.palette",
        "com.github.plugarut.pwned-checker",
        "com.github.artemanufrij.findfileconflicts",
        "com.github.santileortiz.iconoscope",
        "com.github.bleakgrey.transporter",
        "com.github.bartzaalberg.alias",
        "com.github.artemanufrij.graphui",
        "com.github.peteruithoven.resizer",
        "com.github.bartzaalberg.snaptastic",
        "com.github.cjfloss.envelope"
      ]
    }
  end
end
