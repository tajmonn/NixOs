{ config, lib, ... }:
{
  config.var = {
    hostname = "FrameWork";
    username = "tymon";

    # Upgrade/GC opt-ins
    autoUpgrade = false;
    autoGarbageCollector = true;

    # NixOS config directory
    configDirectory = "/home/" + config.var.username + "/.config/nixos";

    # Git config
    git = {
      username = "tajmonn";
      email = "fuatita@gmail.com";
    };

    # Locale & Keyboard
    location = "Warsaw";
    timeZone = "Europe/Warsaw";
    defaultLocale = "pl_PL.UTF-8";
    extraLocale = "pl_PL.UTF-8";
    keyboardLayout = "pl";
  };

  options = {
    var = lib.mkOption {
      type = lib.types.attrs;
      default = { };
    };
  };
}
