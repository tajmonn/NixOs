{
  description = "NixOS config with access to stable and unstable for both users";

  inputs = {
    # Stable nixpkgs
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";

    # Unstable nixpkgs
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-stable";

    # silentSDDM login manager by uiriansan
    silentSDDM = {
      url = "github:uiriansan/silentSDDM";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

  };

  outputs = { self, nixpkgs-stable, nixpkgs-unstable, home-manager, ... }:
  let
    system = "x86_64-linux";

    pkgsStable = nixpkgs-stable.legacyPackages.${system};
    pkgsUnstable = nixpkgs-unstable.legacyPackages.${system};
  in
  {
    nixosConfigurations.FrameWork = nixpkgs-stable.lib.nixosSystem {
      inherit system;

      modules = [
        { nixpkgs.config = { allowUnfree = true; }; }
        ./hosts/FrameWork.nix
        ./modules/hyprland.nix
        ./modules/xfce.nix
        ./modules/sddm-theme.nix
        ./common.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = false;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
        }
      ];

      # Pass unstable packages to modules via specialArgs
      specialArgs = {
        pkgsUnstable = pkgsUnstable;
        silentSDDM = silentSDDM;
      };
    };
  };
}
