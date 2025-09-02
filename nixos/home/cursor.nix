{ pkgs, lib, ... }:
{
  # Cursor setup
  home.pointerCursor = {
    hyprcursor.enable = true;
    hyprcursor.size = 14;

    package = pkgs.bibata-cursors;

    enable = true;
    gtk.enable = true;
    x11.enable = true;

    name = "Bibata-Modern-Classic";
    size = 14;
  };
}
