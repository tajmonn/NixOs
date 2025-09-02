{ config, pkgs, inputs, lib, ... }:

let
  patchPapirus = pkgs.stdenv.mkDerivation {
    name = "${pkgs.papirus-icon-theme.name}-patch";
    src = pkgs.papirus-icon-theme;
    installPhase = ''
      mkdir -p $out/share/icons
      # Quickshell only finds icons in share/icons/hicolor
      cp -r $src/share/icons/Papirus $out/share/icons/hicolor
    '';
  };
in
{
  # Caelestia program config
  programs.caelestia = {
    enable = true;
    settings = { };
    cli = {
      enable = true;
      settings = { };
    };
  };

  systemd.user.services.caelestia = {
    Service = {
      ExecStart = lib.mkForce "${pkgs.writeShellScript "caelestia-wrapper" ''
        export XDG_DATA_DIRS=$XDG_DATA_DIRS:${patchPapirus}/share

        ${config.programs.caelestia.package}/bin/caelestia-shell
      ''}";
    };
  };

  # Configuration files
  xdg.configFile = {
    # Main caelestia shell configuration
    "quickshell/caelestia" = {
      source = ./shell;
      recursive = true;
    };

    # Fish completions (our fixed version)
    "fish/completions/caelestia.fish" = {
      source = ./caelestia-completions.fish;
    };

    # Your custom scripts.json for toggle workspaces
    "caelestia/scripts.json" = {
      source = ./shell/scripts.json;
    };
  };

  # Data files
  xdg.dataFile = {
    # Scripts directory (from the packaged scripts)
    "caelestia/scripts" = {
      source = "${config.programs.quickshell.caelestia-cli}/share/caelestia-cli";
      recursive = true;
    };
  };

  # Environment variables
  home.sessionVariables = {
    C_DATA = "${config.xdg.dataHome}/caelestia";
    C_STATE = "${config.xdg.stateHome}/caelestia";
    C_CACHE = "${config.xdg.cacheHome}/caelestia";
    C_CONFIG = "${config.xdg.configHome}/caelestia";
  };

  # Directory setup and permissions
  home.activation.caelestiaSetup = lib.hm.dag.entryAfter ["writeBoundary"] ''
    # Create required directories
    mkdir -p ${config.xdg.dataHome}/caelestia
    mkdir -p ${config.xdg.stateHome}/caelestia/scheme
    mkdir -p ${config.xdg.cacheHome}/caelestia/thumbnails
    mkdir -p ${config.xdg.configHome}/caelestia

    # Ensure state files are writable (fix permission issues)
    if [ -d ${config.xdg.stateHome}/caelestia/scheme ]; then
      find ${config.xdg.stateHome}/caelestia/scheme -name "*.txt" -exec chmod u+w {} \; 2>/dev/null || true
    fi
  '';
}
