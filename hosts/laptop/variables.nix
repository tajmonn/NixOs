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
    defaultLocale = "en_US.UTF-8";    # English locale
    extraLocale = "en_US.UTF-8";      # English locale
    keyboardLayout = "pl";
  };

  options = {
    var = lib.mkOption {
      type = lib.types.attrs;
      default = { };
    };
  };
}
