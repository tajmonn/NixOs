{ nixpkgs-unstable, config, inputs, lib, ... }:
let
  border-size = "2";
  gaps-in = "6";
  gaps-out = "6";
  active-opacity = "1.0";
  inactive-opacity = "0.69";
  rounding = "17";
  keyboardLayout = config.var.keyboardLayout;
in
{
  imports = [
    ./animations.nix
    ./bindings.nix
  ];

  home.packages = with nixpkgs-unstable; [
    libsForQt5.qt5ct
    wayland-utils
    wayland-protocols
    hyprpolkitagent
    hyprshot
    hyprpicker
    wlr-randr
    wl-clipboard
    libva
    dconf
    glib
    direnv
    meson
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    systemd = {
      enable = false;
      variables = [ "--all" ];
    };

    package = null;
    portalPackage = null;

    settings = {
      "$mod" = "SUPER";
      "$shiftMod" = "SUPER_SHIFT";

      exec-once = [
        "dbus-update-activation-environment --systemd --all &"
        "systemctl --user start hyprpolkitagent &"
        "systemctl --user enable --now hypridle.service &"
        "hyprctl setcursor bibata-cursors-translucent-ghost 14"
        "qs -c caelestia &"
      ];

      monitor = [
        ",2256x1504,auto,1"
      ];

      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
        "MOZ_ENABLE_WAYLAND,1"
        "ANKI_WAYLAND,1"
        "DISABLE_QT5_COMPAT,0"
        "NIXOS_OZONE_WL,1"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_QPA_PLATFORM=wayland,xcb"
        "QT_QPA_PLATFORMTHEME=qt6ct"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        "__GL_GSYNC_ALLOWED,1"
        "__GL_VRR_ALLOWED,1"
        "DIRENV_LOG_FORMAT,"
        "WLR_DRM_NO_ATOMIC,1"
        "WLR_BACKEND,vulkan"
        "WLR_RENDERER,vulkan"
        "WLR_NO_HARDWARE_CURSORS,1"
        "SDL_VIDEODRIVER,wayland,x11"
        "CLUTTER_BACKEND,wayland"
        "STEAM_FORCE_DESKTOPUI_SCALING,1"
        "STEAM_USE_MANGOAPP,0"
      ];

      cursor = {
        no_hardware_cursors = true;
        default_monitor = "DP-1";
      };

      general = {
        resize_on_border = true;
        gaps_in = gaps-in;
        gaps_out = gaps-out;
        border_size = border-size;
        layout = "master";
      };

      decoration = {
        active_opacity = active-opacity;
        inactive_opacity = inactive-opacity;
        rounding = rounding;
        shadow = {
          enabled = true;
          range = 8;
          render_power = 3;
        };
        blur = {
          enabled = true;
          size = 6;
        };
      };

      master = {
        new_status = true;
        allow_small_split = true;
        mfact = 0.5;
      };

      gestures = { };

      misc = {
        vfr = true;
        vrr = 1;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        disable_autoreload = false;
        focus_on_activate = true;
        new_window_takes_over_fullscreen = 2;
        middle_click_paste = false;
      };

      layerrule = [ "noanim, launcher" "noanim, ^args-.*" ];

      input = {
        kb_layout = keyboardLayout;
        follow_mouse = 1;
        sensitivity = 1;
        repeat_delay = 300;
        repeat_rate = 50;
      };
    };
  };
}
