{ pkgs, lib, config, ... }:
{
    imports = [
        # User Specific Config
        ./variables.nix

        # System
        ../../home/system/cursor
        ../../home/system/fish-shell
        ../../home/system/git
        ../../home/system/hypridle
        ../../home/system/hyprland
        ../../home/system/hyprlock
        ../../home/system/neofetch
        

        # Programs
        # ../../home/programs/discord
        ../../home/programs/ghostty
        # ../../home/programs/spicetify

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

            # Work
            remmina

            # Development - Languages/Tools
            python3

            # Development - IDE
            vscode

            # Utilities
            grc
            zip
            unzip
            tree
            btop
            fish
            neofetch
            gtk3

            # Misc
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
