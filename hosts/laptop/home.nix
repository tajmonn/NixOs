{ pkgs, lib, config, ... }:
{
    imports = [
        # User Specific Config
        ./variables.nix

        # System
        ../../home/system/hyprland
        ../../home/system/hypridle
        ../../home/system/hyprlock
        ../../home/system/cursor
        ../../home/system/fish-shell
        ../../home/system/git

        # Programs
        ../../home/programs/discord
        ../../home/programs/ghostty
        ../../home/programs/spicetify

        # Shell
        ../../home/quickshell
    ];

    home = {
        # Set the home directory path for our user
        inherit (config.var) username;
        homeDirectory = "/home/" + config.var.username;

        # Packages
        packages = with pkgs; [
            # Apps
            firefox

            # Development - Languages/Tools
            python3
            remmina

            # Development - IDE
            vscode
            gh

            # Utilities
            grc
            zip
            unzip
            tree
            btop
            fish
            neofetch
            gtk3
            thunar

            # Misc
            cava
            bluez
            ddcutil
            brightnessctl
            imagemagick
        ];

        # State version
        stateVersion = "25.05";
    };

    # Enable Home Manager
    programs.home-manager = {
        enable = true;
    };
}
