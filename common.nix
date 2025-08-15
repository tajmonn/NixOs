{ config, pkgs, ... }:

{
  # System-wide package manager settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  programs.zsh.enable = true;


  # Common utilities system-wide 
  environment.systemPackages = with pkgs; [
    wget 
    curl 
    git 
    neofetch 
    unzip 
    htop 
    pciutils 
    usbutils 
    neovim 
    firefox
    gh
    rofi-wayland
    vscode
    kitty
    xfce.thunar-archive-plugin
    xarchiver
    ruby
    bundler
    remmina
    
  ];

  # Enable flakes and nix-command globally 
  programs.nix-ld.enable = true;
}