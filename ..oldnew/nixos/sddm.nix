{config, pkgs, nixpkgs-unstable, inputs, silentSDDM, ...}:

let 
  sddm-theme = silentSDDM.packages.${pkgs.system}.default.override {
    theme = "default"; # theme name 
  };
in {
  environment.systemPackages = [ sddm-theme sddm-theme.test ];
  qt.enable = true;

  services.displayManager.sddm = {
    package = pkgs.kdePackages.sddm; # qt6 version of sddm
    enable = true;
    theme = sddm-theme.pname;
    extraPackages = sddm-theme.propagatedBuildInputs;
    settings = {
      General = {
        GreeterEnvironment = "QML2_IMPORT_PATH=${sddm-theme}/share/sddm/themes/${sddm-theme.pname}/components/,QT_IM_MODULE=qtvirtualkeyboard";
        InputMethod = "qtvirtualkeyboard";
      };
      Wayland.SessionDir = "${inputs.hyprland.packages."${nixpkgs-unstable.system}".hyprland}/share/wayland-sessions";
    };
  };
}

