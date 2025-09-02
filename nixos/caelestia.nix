{ config, pkgs, lib, ... }:

let
  patchPapirus = pkgs.stdenv.mkDerivation {
    name = "${pkgs.papirus-icon-theme.name}-patch";
    src = pkgs.papirus-icon-theme;
    installPhase = ''
      mkdir -p $out/share/icons
      cp -r $src/share/icons/Papirus $out/share/icons/hicolor
    '';
  };
in {
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
}
