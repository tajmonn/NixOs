{ config, pkgs, ... }:

{
    # Enable X11 server (needed for XFCE)
    services.xserver.enable = true;

    # Enable the XFCE desktop environment
    services.xserver.desktopManager.xfce.enable = true;

    # Optional: make sure common clipboard tools are avaliable
    environment.systemPackages = with pkgs; [
        xfce.xfce4-whiskermenu-plugin
        xfce.xfce4-clipman-plugin
        xfce.thunar
        xfce.thunar-archive-plugin
        gvfs
        gnome-keyring
        networkmanagerapplet
    ];
}