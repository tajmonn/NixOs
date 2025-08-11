{ config, pkgs, pkgsUnstable, ... }:

{
  # Enable Hyprland session for SDDM
  services.displayManager.sessionPackages = [ pkgs.hyprland ];

  # Ensure SDDM is enabled
  services.displayManager.sddm.enable = true;

  # Enable X11 server support (needed for Hyprland + XWayland)
  services.xserver.enable = true;

  # Enable Hyprland
  programs.hyprland.enable = true;

  # Install Quickshell from unstable + any other system packages
  environment.systemPackages = [
    (pkgsUnstable.quickshell)
  ];

}
