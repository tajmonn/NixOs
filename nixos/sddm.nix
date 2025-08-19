{ config, pkgs, inputs, ... }:

let
  sddm-theme = inputs.silentSDDM.packages.${pkgs.system}.default.override {
    theme = "default";
  };
in
{
  environment.systemPackages = [ sddm-theme sddm-theme.test ];

  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
    theme = sddm-theme.pname;
    extraPackages = sddm-theme.propagatedBuildInputs;
    settings = {
      General = {
        GreeterEnvironment = "QML2_IMPORT_PATH=${sddm-theme}/share/sddm/themes/${sddm-theme.pname}/components/,QT_IM_MODULE=qtvirtualkeyboard";
        InputMethod = "qtvirtualkeyboard";
      };
    };
  };
}
