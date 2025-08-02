{ config, pkgs, ... }:

{
    # Enable hyrpland session for SDDM
    services.displayManager.sessionPackages = [ pkgs.hyprland ];

    # Ensure SDDM is enabled (you can adjust or disable if you use another DM)
    services.displayManager.sddm.enable = true;

    # Enable X11 server support (needed for Hyprland and fallback & XWayland)
    services.xserver.enable = true;

    # From wiki
    programs.hyprland.enable = true;
    environment.systemPackages = [
        pkgs.kitty # required for the default Hyprland config
    ];

    # Basic Hyprland config deployed system-wide
    environment.etc."hyprland.conf".text = ''
        monitor=eDP-1,2256x1506@60,0x0,1
        # TODO add custom binds and settings
    '';



}