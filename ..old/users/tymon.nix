{ config, pkgs, lib, pkgsUnstable, ... }:

{
  home.username = "tymon";
  home.homeDirectory = lib.mkForce "/home/tymon";
  
  # Copy your local config directory into ~/.config/hypr
  home.file.".config/hypr" = {
    source = ./tymon; # relative to users/tymon.nix
    recursive = true;
  };

  home.stateVersion = "25.05";
}
