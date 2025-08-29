{ pkgs, ... }:
let
  totalWorkspaces = 9;
in
{
  wayland.windowManager.hyprland.settings = {
    bind = [
      # Kill active window
      "$mod, Q, killactive"

      "$mod, mouse:272, moveWindow" # Move
      "$mod, mouse:274, moveWindow" # [hidden]
      "$mod, mouse:273, resizeWindow" # Resize

      "$mod, Left, moveFocus, l"
      "$mod, Right, moveFocus, r"
      "$mod, Up, moveFocus, u"
      "$mod, Down, moveFocus, d"

      "$mod+Shift, Left, moveWindow, l"
      "$mod+Shift, Right, moveWindow, r"
      "$mod+Shift, Up, moveWindow, u"
      "$mod+Shift, Down, moveWindow, d"

      "$mod, Semicolont, splitratio, -0.1"
      "$mod, Apostophe, splitratio, +0.1"

      "$mod+Alt, SPACE, togglefloating"
      "$mod. P, pin"


      # Bindings to open applications
      "$mod, C, exec, code"         # Open VS Code
      "$mod, RETURN, exec, ghostty"  # Open Ghostty terminal
      "$mod, W, exec, firefox"        # Open Firefox browser
      "$mod, E, exec, thunar"         # Open thunar

      # Screenshot with hyprshot
      "$mod, Print, exec, ~/.config/nixos/home/system/hyprland/scripts/hyprshot.sh region"
      "$shiftMod, Print, exec, ~/.config/nixos/home/system/hyprland/scripts/hyprshot.sh monitor"

      # Caelestia shell bindings
      "$mod, SPACE, exec, caelestia-quickshell shell toggle launcher"
      "$mod, D, exec, caelestia-quickshell shell toggle dashboard"
      "$mod, S, exec, caelestia-quickshell shell toggle session"
    ] ++ ( builtins.concatLists(builtins.genList (i:
      let ws = i + 1;
      in [
        "$mod, code:1${toString i}, workspace, ${toString ws}"
        "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
      ]) totalWorkspaces
    ));
  };
}
