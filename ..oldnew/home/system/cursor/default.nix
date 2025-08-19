{ pkgs, lib, ... }:
{
  home.pointerCursor = {
    hyprcursor.enable = true;
    hyprcursor.size = 14;

    package = pkgs.bibata-cursors-translucent;

    enable = true;
    gtk.enable = true;
    x11.enable = true;

    name = "bibata-cursors-translucent-ghost";
    size = 14;
  };
}
