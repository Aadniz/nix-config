{ lib, pkgs, config, ... }:

# Big creds to https://github.com/RicArch97/nixos-config/blob/b2a94a998b9ada4635ba1ce702691098f799b100/modules/desktop/sway.nix
# and https://github.com/RaitoBezarius/nixos-home/blob/70a7d0503da62963c03cee40962f945f552dd6f1/sway.nix

let
  cfg = config.wayland.windowManager;
  workspaceNumberToFrenchSymbol = {
    "1" = "ampersand";
    "2" = "eacute";
    "3" = "quotedbl";
    "4" = "apostrophe";
    "5" = "parenleft";
    "6" = "minus";
    "7" = "egrave";
    "8" = "underscore";
    "9" = "ccedilla";
    "10" = "agrave";
  };
  workspaces = lib.range 1 10;
  mkWorkspaceSym = symFn: valueFn: mod:
    lib.listToAttrs (map (index:
    let sym = workspaceNumberToFrenchSymbol.${toString index};
    in { name = (symFn mod sym index); value = valueFn index; }) workspaces);
  mkMoveToWorkspace = mkWorkspaceSym
    (mod: sym: _: "${mod}+${sym}")
    (index: "workspace ${toString index}");
  mkMoveContainerToWorkspace = mkWorkspaceSym
    # Nix has no % operator ???
    (mod: sym: index: if index >= 6 then (if index == 10 then "${mod}+Shift+0" else "${mod}+Shift+${toString index}")
    else "${mod}+Shift+${sym}")
    (index: "move container to workspace number ${toString index}");
in
{
  imports = [
    ./hardware.nix
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
    brillo
    wl-clipboard
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
        # Idle configuration
      #  { command = ''swayidle -w \
      #    timeout 300 'swaylock -f -c 000000' \
      #    timeout 600 'swaymsg "output * dpms off"' \
      #      resume 'swaymsg "output * dpms on"' \
      #    before-sleep 'swaylock -f -c 000000'
      #    '';
      #  }
      ];


      keybindings = lib.mkOptionDefault ({
        "${modifier}+KP_Enter" = "exec kitty";
        "${modifier}+Ctrl+Return" = "exec kitty --class floatingKitty";
        "${modifier}+Ctrl+KP_Enter" = "exec kitty --class floatingKitty";
        "${modifier}+Escape" = "kill";
        "${modifier}+Delete" = "kill";
        "${modifier}+q" = "exec rofi -show run";

        # Audio
        "XF86AudioMute" = "exec pamixer -t && pkill -RTMIN+1 ${pkgs.i3blocks}";
        "XF86AudioLowerVolume" = "exec pamixer -d 1 && pkill -RTMIN+1 ${pkgs.i3blocks}";
        "XF86AudioRaiseVolume" = "exec pamixer -i 1 && pkill -RTMIN+1 ${pkgs.i3blocks}";
        "XF86AudioPlay" = "exec playerctl play-pause && pkill -RTMIN+10 ${pkgs.i3blocks}";
        "XF86AudioNext" = "exec playerctl next && pkill -RTMIN+10 ${pkgs.i3blocks}";
        "XF86AudioPrev" = "exec playerctl previous && pkill -RTMIN+10 ${pkgs.i3blocks}";


        "Shift+Print" = "exec grim - | wl-copy";
        "Shift+Alt+Print" = ''exec grim -g "$(slurp)" - | wl-copy'';
        "Print" = "exec --no-startup-id flameshot gui";
        "${modifier}+l" = "exec swaylock -f -c 000000";
        "${modifier}+p" = "exec wpctl set-mute @DEFAULT_SINK@ toggle";
        # TODO: quick edit /etc/nixos as root
        # TODO: quick commit to my repository, the changes.
        "${modifier}+Shift+a" = "gksudo nrs --no-build-nix";
        "${modifier}+m" = "move workspace to output left";
        "${modifier}+r" = "mode resize";
        "${modifier}+s" = "scratchpad show";
        "${modifier}+Shift+s" = "move scratchpad";
      } // (mkMoveToWorkspace modifier) // (mkMoveContainerToWorkspace modifier));

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
