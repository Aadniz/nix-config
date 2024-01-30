{ config, lib, pkgs, term, theme, ... }:

let
  lockCommand = ''${pkgs.swaylock}/bin/swaylock -f -c 000000 --line-color "${theme.background}" --ring-color "${theme.background}" --key-hl-color "${theme.primary}" --inside-color 000000'';
  # Default movement keys (arrow keys, TKL keyboard)
  modifier = "Mod4";
  left = "Left";
  down = "Down";
  up = "Up";
  right = "Right";
  # Generate a list of lists, each inner list containing a key(number) and workspace
  workspaces = lib.genList (x: [(toString (x)) (toString (x))]) 10;
  numpad = {
    "0" = "KP_Insert";
    "1" = "KP_End";
    "2" = "KP_Down";
    "3" = "KP_Next";
    "4" = "KP_Left";
    "5" = "KP_Begin";
    "6" = "KP_Right";
    "7" = "KP_Home";
    "8" = "KP_Up";
    "9" = "KP_Prior";
  };
in
{
  wayland.windowManager.sway.config.keybindings = {
    "${modifier}+Return" = "exec ${term}";
    "${modifier}+KP_Enter" = "exec ${term}";
    "${modifier}+Ctrl+Return" = "exec ${term} --class floatingKitty";
    "${modifier}+Ctrl+KP_Enter" = "exec ${term} --class floatingKitty";
    "${modifier}+Escape" = "kill";
    "${modifier}+Delete" = "kill";
    "${modifier}+q" = "exec ${pkgs.rofi}/bin/rofi -show drun";
    "${modifier}+Shift+c" = "reload";
    "${modifier}+space" = "floating toggle";
    "${modifier}+Backspace" = "exec ${lockCommand}";

    # Audio
    "XF86AudioMute" = "exec ${pkgs.pamixer}/bin/pamixer -t && pkill -RTMIN+1 i3blocks";
    "XF86AudioLowerVolume" = "exec ${pkgs.pamixer}/bin/pamixer -d 1 && pkill -RTMIN+1 i3blocks";
    "XF86AudioRaiseVolume" = "exec ${pkgs.pamixer}/bin/pamixer -i 1 && pkill -RTMIN+1 i3blocks";
    "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause && pkill -RTMIN+10 i3blocks";
    "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next && pkill -RTMIN+10 i3blocks";
    "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous && pkill -RTMIN+10 i3blocks";

    # Moving focus
    "${modifier}+${left}" = "focus left";
    "${modifier}+${down}" = "focus down";
    "${modifier}+${up}" = "focus up";
    "${modifier}+${right}" = "focus right";
    "${modifier}+Shift+${left}" = "move left";
    "${modifier}+Shift+${down}" = "move down";
    "${modifier}+Shift+${up}" = "move up";
    "${modifier}+Shift+${right}" = "move right";
    "Alt+Tab" = "workspace back_and_forth";
    "${modifier}+Tab" = "workspace next_on_output";
    "${modifier}+a" = "focus parent";
    "${modifier}+d" = "focus mode_toggle";

    # Scratchpad
    "${modifier}+Shift+minus" = "move scratchpad";
    "${modifier}+minus" = "scratchpad show";

    # Screenshot
    "Print" = ''exec wl-copy < $(${pkgs.sway-contrib.grimshot}/bin/grimshot save area "$HOME/Pictures/Shutter/Screenshot_$(date +%Y-%m-%d_%H:%M:%S).png")'';
    "Shift+Print" = ''exec ${pkgs.sway-contrib.grimshot}/bin/grimshot --notify copy area'';
    "Ctrl+Print" = ''exec ${pkgs.sway-contrib.grimshot}/bin/grimshot --notify copy output'';
    "Ctrl+Shift+Print" = ''exec wl-copy < $(${pkgs.sway-contrib.grimshot}/bin/grimshot --notify save output "$HOME/Pictures/Shutter/Screenshot_$(date +%Y-%m-%d_%H:%M:%S).png")'';
    "${modifier}+Print" = ''exec wl-copy < $(${pkgs.sway-contrib.grimshot}/bin/grimshot --notify save screen "$HOME/Pictures/Shutter/Screenshot_$(date +%Y-%m-%d_%H:%M:%S).png")'';
    "Mod1+Print" = ''exec wl-copy < $(${pkgs.sway-contrib.grimshot}/bin/grimshot --notify save active "$HOME/Pictures/Shutter/Screenshot_$(date +%Y-%m-%d_%H:%M:%S).png")'';

    "${modifier}+v" = "splith";
    "${modifier}+c" = "splitv";
    "${modifier}+f" = "fullscreen";
    "${modifier}+s" = "sticky toggle";
    "${modifier}+t" = "layout tabbed";
    "${modifier}+w" = "layout stacking";
    "${modifier}+b" = "border toggle";
    "${modifier}+e" = "layout toggle split";


    "${modifier}+r" = "mode resize";
  }

  # Only bind swaylock to Mod + Backspace if swaylock is installed
  // lib.optionalAttrs (pkgs ? swaylock) {
    "${modifier}+Backspace" = ''exec ${pkgs.swaylock}/bin/swaylock -f -c 000000 --line-color "${theme.background}" --ring-color "${theme.background}" --key-hl-color "${theme.primary}" --inside-color 000000'';
  }

  # Merge KP_number key to focus workspace number with keybind set
  // lib.listToAttrs (builtins.map
    (x: {
      name = "${modifier}+${numpad.${builtins.elemAt x 0}}";
      value = "exec ${pkgs.swaysome}/bin/swaysome focus ${builtins.elemAt x 1}";
    })
    workspaces)

  # Merge KP_number key to move to workspace number with keybind set
  // lib.listToAttrs (builtins.map
    (x: {
      name = "${modifier}+Shift+${numpad.${builtins.elemAt x 0}}";
      value = "exec ${pkgs.swaysome}/bin/swaysome move ${builtins.elemAt x 1}";
    })
    workspaces)

  # Merge KP_number key to focus workspace number with keybind set
  // lib.listToAttrs (builtins.map
    (x: {
      name = "${modifier}+KP_${builtins.elemAt x 0}";
      value = "exec ${pkgs.swaysome}/bin/swaysome focus ${builtins.elemAt x 1}";
    })
    workspaces)

  # Merge KP_number key to move to workspace number with keybind set
  // lib.listToAttrs (builtins.map
    (x: {
      name = "${modifier}+Shift+KP_${builtins.elemAt x 0}";
      value = "exec ${pkgs.swaysome}/bin/swaysome move ${builtins.elemAt x 1}";
    })
    workspaces)

  # Merge number key to focus workspace number with keybind set
  // lib.listToAttrs (builtins.map
    (x: {
      name = "${modifier}+${builtins.elemAt x 0}";
      value = "exec ${pkgs.swaysome}/bin/swaysome focus ${builtins.elemAt x 1}";
    })
    workspaces)

  # Merge number key to move to workspace number with keybind set
  // lib.listToAttrs (builtins.map
    (x: {
      name = "${modifier}+Shift+${builtins.elemAt x 0}";
      value = "exec ${pkgs.swaysome}/bin/swaysome move ${builtins.elemAt x 1}";
    })
    workspaces);

  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = lockCommand;
      }
    ];
    timeouts = [
      {
        timeout = 300;
        command = "swaymsg 'output * power off'";
        resumeCommand = "swaymsg 'output * power on'";
      }
    ];
  };
}
