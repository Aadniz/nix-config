{ lib, pkgs, config, theme, term, ... }:

# Big creds to https://github.com/RicArch97/nixos-config/blob/b2a94a998b9ada4635ba1ce702691098f799b100/modules/desktop/sway.nix
# and https://github.com/RaitoBezarius/nixos-home/blob/70a7d0503da62963c03cee40962f945f552dd6f1/sway.nix
let
  modifier = "Mod4";
in
{
  imports = [
    ./bar.nix
    ./dunst.nix
    ./hardware.nix
    ./keybinds.nix
  ];

  dconf.enable = true;

  home.packages = with pkgs; [
    brillo
    dmenu
    firefox-wayland
    flameshot
    grim
    i3blocks
    pamixer
    playerctl
    qt5.qtwayland
    slurp
    swappy
    sway-contrib.grimshot
    swayidle
    swaysome
    waypipe
    wf-recorder
    wl-clipboard
    xdg-utils
    gnome3.adwaita-icon-theme
    config.nur.repos."999eagle".swayaudioidleinhibit
    swaylock
  ];

  programs.zsh.loginExtra = ''
    if [[ -z $DISPLAY ]] && [[ $(tty) = "/dev/tty1" ]]; then
      exec ${pkgs.sway}/bin/sway
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
    config = rec {
      menu = "${lib.getExe pkgs.wofi} --show run | ${pkgs.findutils}/bin/xargs swaymsg exec --";
      inherit modifier;
      terminal = term;

      fonts = {
        names = [  "Iosevka" "FontAwesome" "Font Awesome 6 Edited" "Font Awesome 6 Brands"];
        size = 11.0;
        style = "Normal";
      };

      startup = [
        {command = "${pkgs.swaysome}/bin/swaysome init 1";}
        {command = "${config.nur.repos."999eagle".swayaudioidleinhibit}/bin/sway-audio-idle-inhibit"; }
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
       text = theme.primary;  # Invisible
       #text = theme.background;
       indicator = theme.primary;
       childBorder = theme.primary;
     };
     colors.unfocused = {
       border = theme.background;
       background = theme.background;
       text = theme.background;  # Invisible
       #text = theme.foreground;
       indicator = theme.background;
       childBorder = theme.background;
     };
     colors.focusedInactive = {
       border = theme.background;
       background = theme.background;
       text = theme.background;  # Invisible
       #text = theme.foreground;
       indicator = theme.background;
       childBorder = theme.background;
     };
      colors.urgent = {
        border = theme.secondary;
        background = theme.secondary;
        text = theme.secondary;  # Invisible
        #text = theme.background;
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
      default_border normal 10
      titlebar_padding 4
      font pango:monospace 1
      bindsym --whole-window {
        ${modifier}+button4 gaps inner current plus 5
        ${modifier}+button5 gaps inner current minus 5
      }
    '';
  };
}
