{ pkgs, lib, config, ... }:
{
    imports = [
        # User Specific Config
        ./variables.nix

        # some stuff
        ../../nixos/home/cursor.nix
        ../../nixos/home/fish-shell.nix
        ../../nixos/home/git.nix

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

        # Copy dotfiles
        file.".config".source = ../../dotfiles/.config;
        file.".config".recursive = true;
        file.".face".source = ../../dotfiles/.face;

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
            xfce.thunar

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
