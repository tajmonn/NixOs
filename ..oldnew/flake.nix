{
  description = "NixOS config";

  inputs = {
    # Stable nixpkgs
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";

    # Unstable nixpkgs
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Hardware
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    # silentSDDM login manager by uiriansan
    silentSDDM = {
      url = "github:uiriansan/silentSDDM";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    # For quickshell if I'm right
    astal = {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # Quickshell
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # Hyprland
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = inputs@{ nixpkgs-stable, nixpkgs-unstable, home-manager, quickshell, ... }: 
  {
    nixosConfigurations = {
      FrameWork = nixpkgs-stable.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          # Expose pkgs-stable/unstable to modules
          {
            _module.args = {
              inherit inputs;
              pkgs-stable = import nixpkgs-stable { system = "x86_64-linux"; };
              pkgs-unstable = import nixpkgs-unstable { system = "x86_64-linux"; };
            };
          }

          # Add Quickshell globally
          {
            environment.systemPackages = [
              quickshell.packages.x86_64-linux.default
            ];
          }

          # Enable Home Manager
          home-manager.nixosModules.home-manager

          # Finally, host-specific config
          ./hosts/laptop/configuration.nix
        ];
      };
    };
  };
}
