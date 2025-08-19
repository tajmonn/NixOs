{ config, lib, nixpkgs-stable, nixpkgs-unstable, ...}:
{
  imports = [
    # System configurations
    ../../nixos/boot-manager.nix
    ../../nixos/audio.nix
    ../../nixos/bluetooth.nix
    ../../nixos/fonts.nix
    ../../nixos/home-manager.nix
    ../../nixos/nix.nix
    ../../nixos/sddm.nix
    ../../nixos/users.nix
    ../../nixos/utils.nix
    ../../nixos/hyprland.nix

    # Machine-specific hardware configuration
    ./hardware-configuration.nix

    # Host specific variables
    ./variables.nix
  ];

  nix.settings = {
    download-buffer-size = 134217728;
  };

  # Nix PM Version
  nix.package = nixpkgs-stable.nixVersions.latest;

  # Setup Home Manager for our user
  home-manager.users."${config.var.username}" = import ./home.nix;

  # NixOS Version
  system.stateVersion = "25.05";
}
