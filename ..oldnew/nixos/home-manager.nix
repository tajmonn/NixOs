{ inputs, pkgs, ... }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    backupFileExtension = "hm-backup";

    extraSpecialArgs = { inherit inputs; };
  };

  # Home Manager configuration
  home.file = {
    # Copy/link a single file
    ".zshrc".source = ./dotfiles/zshrc;

    # Copy/link a directory
    ".config/nvim".source = ./dotfiles/nvim;

    # Another example: .gitconfig
    ".gitconfig".source = ./dotfiles/gitconfig;
  };
}
