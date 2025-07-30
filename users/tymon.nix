{ pkgs, ... }:

{
  # Use zsh as default shell
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      theme = "agnoster";
      plugins = [ "git" "z" "colored-man-pages" ];
    };
  };
  
  # Essential packages for tymon user
  home.stateVersion = "24.05";
  home.packages = with pkgs; [
    steam
    vesktop
    spotify
    spicetify-cli
  ];

  # Enable some basic systemd user services
  services = {
    dbus.enable = true;
  };

  # Environment variables, e.g. for gaming optimization
  environment.variables = {
    MOZ_ENABLE_WAYLAND = "1"; # Firefox wayland support
    WLR_NO_HARDWARE_CURSORS = "1"; # Sometime improves sursor on Wayland
  };

  # Enable XDG autostart for some programs if needed
  xdg.autostart.enable = true;

}