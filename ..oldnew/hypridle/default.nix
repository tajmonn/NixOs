# HyprIdle is a daemon that listens for user activity and runs commands when the user has been deemed idle.
{ pkgs, lib, ... }:
{
  services.hypridle = {
    enable = true;
    
    settings = {
      general = {
        ignore_dbus_inhibit = false;
        lock_cmd = "pidof hyprlock || ${pkgs.hyprlock}/bin/hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 600;
          on-timeout = "pidof hyprlock || {$pkgs.hyprlock}/bin/hyprlock";
        }
      ];
    };
  };

  systemd.user.services.hypridle.Unit.After = lib.mkForce "graphic-session.target";

}
