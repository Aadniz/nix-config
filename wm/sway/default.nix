{ lib, pkgs, config, theme, term, ... }:

# Big creds to https://github.com/RicArch97/nixos-config/blob/b2a94a998b9ada4635ba1ce702691098f799b100/modules/desktop/sway.nix
# and https://github.com/RaitoBezarius/nixos-home/blob/70a7d0503da62963c03cee40962f945f552dd6f1/sway.nix
let
  modifier = "Mod4";
in
{
  imports = [
    ./hardware.nix
    ./bar.nix
    ./dunst.nix
    ./keybinds.nix
  ];

  #home.file."deleteme".text = colors.colors.color2;

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
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    dmenu
  ];

  programs.zsh.loginExtra = ''
    if [[ -z $DISPLAY ]] && [[ $(tty) = "/dev/tty1" ]]; then
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
      export XDG_CURRENT_DESKTOP=sway
      export XDG_SESSION_TYPE=wayland
      export MOZ_ENABLE_WAYLAND=1
      export _JAVA_AWT_WM_NONREPARENTING=1
    '';
    config = rec {
      menu = "${lib.getExe pkgs.wofi} --show run | ${pkgs.findutils}/bin/xargs swaymsg exec --";
      inherit modifier;
      terminal = term;

      fonts = {
        names = [ "pango:Fira Mono for Powerline" "FontAwesome 10" ];
        size = 10.0;
        style = "Normal";
      };

      startup = [
        {command = "${pkgs.swaysome}/bin/swaysome init 1";}
      ];

      #floating.criteria = [
      #  { app_id = "zenity"; }
      #];
      window = import ./windows.nix;
      floating = {
        border = 2;
        titlebar = true;
        criteria = import ./floating.nix;
      };

     colors.focused = {
       border = theme.primary;
       background = theme.primary;
       text = theme.background;
       indicator = theme.primary;
       childBorder = theme.primary;
     };
     colors.unfocused = {
       border = theme.background;
       background = theme.background;
       text = theme.foreground;
       indicator = theme.background;
       childBorder = theme.background;
     };
     colors.focusedInactive = {
       border = theme.background;
       background = theme.background;
       text = theme.foreground;
       indicator = theme.background;
       childBorder = theme.background;
     };
      colors.urgent = {
        border = theme.secondary;
        background = theme.secondary;
        text = theme.background;
        indicator = theme.secondary;
        childBorder = theme.background;
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
      extraConfig = ''
      floating_minimum_size 250 x 100
      title_align center
      smart_borders on
      default_border normal 4
      bindsym --whole-window {
        ${modifier}+button4 gaps inner current plus 5
        ${modifier}+button5 gaps inner current minus 5
      }
    '';
  };
}
