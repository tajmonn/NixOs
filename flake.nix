{
    description = "NixOS config with access to stable and unstable for both users";

    inputs = {
        # Stable nixpkgs
        nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";

        # Unstable nixpkgs
        nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

        home-manager.url = "github:nix-community/home-manager/release-25.05";
        home-manager.inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    outputs = { self, nixpkgs-stable, nixpkgs-unstable, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs-stable = import nixpkgs-stable { inherit system; config.allowUnfree = true; };
    pkgs-unstable = import nixpkgs-unstable { inherit system; config.allowUnfree = true; };
  in {
    nixosConfigurations.FrameWork = pkgs-stable.lib.nixosSystem {
      inherit system;
      modules = [
        { pkgsUnstable = pkgs-unstable; }
        ./hosts/FrameWork.nix
        ./modules/hyprland.nix
        ./modules/xfce.nix
        ./common.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = false;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
        }
      ];
    };
  };
}
