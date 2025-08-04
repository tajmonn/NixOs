{pkgs, ... }:

{
  # Use zsh as default shell
  programs.zsh.enable = true;
  
  # Essential packages for tymon user
  home.stateVersion = "25.05";
  home.packages = with pkgs; [
    steam
    vesktop
    spotify
    spicetify-cli
  ];

  # Link Hyprland config from repo to ~/.config
  home.file.".config/hypr/".source = ./tymon/;

  # # Environment variables, e.g. for gaming optimization
  # environment.variables = {
  #   MOZ_ENABLE_WAYLAND = "1"; # Firefox wayland support
  #   WLR_NO_HARDWARE_CURSORS = "1"; # Sometime improves sursor on Wayland
  # };

}