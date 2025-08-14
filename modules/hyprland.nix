{ config, pkgs, pkgsUnstable, ... }:

{
    # Enable Hyprland session for SDDM
    services.displayManager.sessionPackages = [ pkgs.hyprland ];

    # Enable SDDM (login manager)
    services.displayManager.sddm.enable = true;

    # Enable X11 server (required for XWayland)
    services.xserver.enable = true;

    # Enable Hyprland window manager
    programs.hyprland.enable = true;

    # Install Quickshell from unstable nixpkgs
    environment.systemPackages = [
        pkgsUnstable.quickshell
        pkgs.playerctl
        pkgs.jq
    ];
}
