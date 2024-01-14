{ lib, pkgs, config, ... }:

# Big creds to https://github.com/RicArch97/nixos-config/blob/b2a94a998b9ada4635ba1ce702691098f799b100/modules/desktop/sway.nix
# and https://github.com/RaitoBezarius/nixos-home/blob/70a7d0503da62963c03cee40962f945f552dd6f1/sway.nix

{
  imports = [
    ./hardware.nix
#    ./bar.nix
  ];

  #home.file.".config/sway/config".source =
  #  config.lib.file.mkOutOfStoreSymlink ./dotfiles/sway;
  #home.file.".config/waybar/config".source = ./dotfiles/waybar/config;
  #home.file.".config/waybar/style.css".source = ./dotfiles/waybar/style.css;

  dconf.enable = true;

  home.packages = with pkgs; [
    swaylock
    grim
    slurp
    swappy
    flameshot
    swaysome
    swayidle
    i3blocks
    waypipe
    wf-recorder
    xdg-utils
    firefox-wayland
    brillo
    wl-clipboard
    playerctl
    pamixer
  ];

  programs.zsh.loginExtra = ''
    if [[ -z $DISPLAY ]] && [[ $(tty) = "/dev/tty1" ]]; then
      export XDG_CURRENT_DESKTOP=sway
      export XDG_SESSION_TYPE=wayland
      exec sway
    fi
  '';

  # Mako systemd service.
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures = {
      base = true;
      gtk = true;
    };
    xwayland = true;
    systemd.enable = true;
    extraSessionCommands = ''
      export XDG_SESSION_TYPE=wayland
      export XDG_CURRENT_DESKTOP=sway
      export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
      export QT_AUTO_SCREEN_SCALE_FACTOR=0
      export QT_SCALE_FACTOR=1
      export GDK_SCALE=1
      export GDK_DPI_SCALE=1
      export MOZ_ENABLE_WAYLAND=1
      export _JAVA_AWT_WM_NONREPARENTING=1
    '';
    config = rec {
      modifier = "Mod4";
      terminal = "kitty";
      menu = "${lib.getExe pkgs.wofi} --show run | ${pkgs.findutils}/bin/xargs swaymsg exec --";

      fonts = {
        names = [ "pango:Fira Mono for Powerline" "FontAwesome 10" ];
        size = 9.0;
        style = "Normal";
      };

      startup = [
        {command = "${pkgs.swaysome}/bin/swaysome init 1";}
      ];


      keybindings = let
        inherit (config.home.manager.wayland.windowManager.sway.config);
        # Default movement keys (arrow keys, TKL keyboard)
        left = "Left";
        down = "Down";
        up = "Up";
        right = "Right";
        # Generate a list of lists, each inner list containing a key(number) and workspace
        workspaces = lib.genList (x: [(toString (x)) (toString (x))]) 10;
      in
      {
        "${modifier}+Return" = "exec ${terminal}";
        "${modifier}+KP_Enter" = "exec ${terminal}";
        "${modifier}+Ctrl+Return" = "exec ${terminal} --class floatingKitty";
        "${modifier}+Ctrl+KP_Enter" = "exec ${terminal} --class floatingKitty";
        "${modifier}+Escape" = "kill";
        "${modifier}+Delete" = "kill";
        "${modifier}+q" = "exec ${pkgs.rofi}/bin/rofi -show run";

        # Audio
        "XF86AudioMute" = "exec ${pkgs.pamixer}/bin/pamixer -t && pkill -RTMIN+1 ${pkgs.i3blocks}/bin/i3blocks";
        "XF86AudioLowerVolume" = "exec ${pkgs.pamixer}/bin/pamixer -d 1 && pkill -RTMIN+1 ${pkgs.i3blocks}/bin/i3blocks";
        "XF86AudioRaiseVolume" = "exec ${pkgs.pamixer}/bin/pamixer -i 1 && pkill -RTMIN+1 ${pkgs.i3blocks}/bin/i3blocks";
        "XF86AudioPlay" = "exec ${pkgs.playerctl} play-pause && pkill -RTMIN+10 ${pkgs.i3blocks}/bin/i3blocks";
        "XF86AudioNext" = "exec ${pkgs.playerctl} next && pkill -RTMIN+10 ${pkgs.i3blocks}/bin/i3blocks";
        "XF86AudioPrev" = "exec ${pkgs.playerctl} previous && pkill -RTMIN+10 ${pkgs.i3blocks}/bin/i3blocks";

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

        "${modifier}+space" = "floating toggle";
        "${modifier}+a" = "focus parent";
        "${modifier}+d" = "focus mode_toggle";
        "${modifier}+Shift+minus" = "move scratchpad";
        "${modifier}+minus" = "scratchpad show";

        "Shift+Print" = "exec grim - | wl-copy";
        "Shift+Alt+Print" = ''exec grim -g "$(slurp)" - | wl-copy'';
        "Print" = "exec --no-startup-id flameshot gui";
        "${modifier}+l" = "exec swaylock -f -c 000000";
        "${modifier}+p" = "exec wpctl set-mute @DEFAULT_SINK@ toggle";
        "${modifier}+r" = "mode resize";
      }
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

    colors.focused = {
      border = "#f5b6ac";
      background = "#f5b6ac";
      text = "#222d3a";
      indicator = "#f5b6ac";
      childBorder = "#cc0000";
    };
    colors.unfocused = {
      border = "#222d3a";
      background = "#222d3a";
      text = "#a79fa1";
      indicator = "#222d3a";
      childBorder = "#cc0000";
    };
    colors.focusedInactive = {
      border = "#222d3a";
      background = "#222d3a";
      text = "#a79fa1";
      indicator = "#222d3a";
      childBorder = "#cc0000";
    };
    colors.urgent = {
      border = "#ed97f3";
      background = "#ed97f3";
      text = "#222d3a";
      indicator = "#ed97f3";
      childBorder = "#cc0000";
    };

      modes.resize = {
        Left = "resize shrink width 10px";
        Down = "resize grow height 10px";
        Up = "resize shrink height 10px";
        Right = "resize grow width 10px";
        Return = "mode default";
        Escape = "mode default";
      };
    };
  };
}