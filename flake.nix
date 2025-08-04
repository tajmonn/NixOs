{
    description = "NixOS config with different nixpkgs versions per user";

    inputs = {
        # Latest nixpkgs (24.05 rolling) for tymon
        nixpkgs-tymon.url = "github:NixOS/nixpkgs/nixos-25.05";

        # Older, pinned nixpkgs for work
        nixpkgs-work.url = "github:NixOS/nixpkgs/nixos-25.05"; # TODO change later for correct one!

        home-manager.url = "github:nix-community/home-manager/release-25.05";
        home-manager.inputs.nixpkgs.follows = "nixpkgs-tymon";
    };

    outputs = { self, nixpkgs-tymon, nixpkgs-work, home-manager, ... }@inputs:
        let
            system = "x86_64-linux";

            pkgs-tymon = import nixpkgs-tymon {
                inherit system;
                config.allowUnfree = true;
            };

            pkgs-work = import nixpkgs-work {
                inherit system;
            config.allowUnfree = true;
            };
        in {
            nixosConfigurations.FrameWork = nixpkgs-tymon.lib.nixosSystem {
                inherit system;
                modules = [
                    ./hosts/FrameWork.nix
                    ./modules/hyprland.nix
                    ./modules/xfce.nix
                    ./common.nix
                    
                    home-manager.nixosModules.home-manager
                    {
                        home-manager.useGlobalPkgs = false;
                        home-manager.useUserPackages = true;
                        home-manager.users.tymon = import ./users/tymon.nix {
                            pkgs = pkgs-tymon;
                        };
                        home-manager.users.work = import ./users/work.nix {
                            pkgs = pkgs-work;
                        };
                    }
                ];
            };
        };
}
