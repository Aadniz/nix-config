{ config, lib, pkgs, term, theme, ... }:

let
  lockCommand = ''${pkgs.swaylock}/bin/swaylock -f -c 000000 --line-color "${theme.background}" --ring-color "${theme.background}" --key-hl-color "${theme.primary}" --inside-color 000000'';
  # Default movement keys (arrow keys, TKL keyboard)
  modifier = "Mod4";
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
  color-picker = pkgs.writeShellScriptBin "color-picker" /* bash */ ''
    set -e

    output=$(${lib.getExe pkgs.grim} -g "$(${lib.getExe pkgs.slurp} -p)" -t ppm - | convert - -format '%[pixel:p{0,0}]' txt:- | grep -v "ImageMagick")

    HASH_COLOR=$(echo -n $output | awk '{print $3}' | tr -d '#')
    RGB_COLOR=$(echo -n $output | awk '{print $4}')

    convert -size 100x100 xc:"#$HASH_COLOR" "/tmp/$HASH_COLOR.png"
    echo -n "#$HASH_COLOR" | wl-copy
    notify-send --icon="/tmp/$HASH_COLOR.png" --transient "Color Picker" "#$HASH_COLOR $RGB_COLOR"
  '';
in
{
  home.packages = [ color-picker ];
  wayland.windowManager.sway.config.keybindings = {
    "${modifier}+Return" = "exec ${term}";
    "${modifier}+KP_Enter" = "exec ${term}";
    "${modifier}+Ctrl+Return" = "exec ${term} --class floatingKitty";
    "${modifier}+Ctrl+KP_Enter" = "exec ${term} --class floatingKitty";
    "${modifier}+Escape" = "kill";
    "${modifier}+Delete" = "kill";
    "${modifier}+q" = "exec ${lib.getExe pkgs.wofi} --insensitive --show drun";
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
    "${modifier}+Left" = "focus left";
    "${modifier}+Down" = "focus down";
    "${modifier}+Up" = "focus up";
    "${modifier}+Right" = "focus right";
    "${modifier}+h" = "focus left";
    "${modifier}+j" = "focus down";
    "${modifier}+k" = "focus up";
    "${modifier}+l" = "focus right";
    "${modifier}+Shift+Left" = "move left";
    "${modifier}+Shift+Down" = "move down";
    "${modifier}+Shift+Up" = "move up";
    "${modifier}+Shift+Right" = "move right";
    "${modifier}+Shift+h" = "move left";
    "${modifier}+Shift+j" = "move down";
    "${modifier}+Shift+k" = "move up";
    "${modifier}+Shift+l" = "move right";
    "Alt+Tab" = "workspace back_and_forth";
    "${modifier}+Tab" = "workspace next_on_output";
    "${modifier}+a" = "focus parent";
    "${modifier}+d" = "focus mode_toggle";

    # Scratchpad
    "${modifier}+z+minus" = "move scratchpad";
    "${modifier}+z" = "scratchpad show";

    # Screenshot
    "Print" = ''exec wl-copy < $(${pkgs.sway-contrib.grimshot}/bin/grimshot save area "$HOME/Pictures/Shutter/Screenshot_$(date +%Y-%m-%d_%H:%M:%S).png")'';
    "Shift+Print" = ''exec ${pkgs.sway-contrib.grimshot}/bin/grimshot --notify copy area'';
    "Ctrl+Shift+Print" = ''exec ${pkgs.sway-contrib.grimshot}/bin/grimshot --notify copy output'';
    "Ctrl+Print" = ''exec wl-copy < $(${pkgs.sway-contrib.grimshot}/bin/grimshot --notify save output "$HOME/Pictures/Shutter/Screenshot_$(date +%Y-%m-%d_%H:%M:%S).png")'';
    "${modifier}+Print" = ''exec wl-copy < $(${pkgs.sway-contrib.grimshot}/bin/grimshot --notify save screen "$HOME/Pictures/Shutter/Screenshot_$(date +%Y-%m-%d_%H:%M:%S).png")'';
    "Mod1+Print" = ''exec wl-copy < $(${pkgs.sway-contrib.grimshot}/bin/grimshot --notify save active "$HOME/Pictures/Shutter/Screenshot_$(date +%Y-%m-%d_%H:%M:%S).png")'';
    "${modifier}+Bar" = "exec ${lib.getExe color-picker}";

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
        command = "${pkgs.sway}/bin/swaymsg 'output * power off'";
        resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * power on'";
      }
    ];
  };
}
