{ config, lib, pkgs, ... }:
let
  modifier = "Mod4";
in
{
  imports = [
    ./bar.nix
    ./dunst.nix
    ./hardware.nix
    (import ./keybinds.nix { inherit config lib pkgs modifier; })
  ];

  config = lib.mkIf config.services.sway.enable {
    hm.dconf.enable = true;

    environment.systemPackages = with pkgs; [
      arandr
      bemenu # wayland clone of dmenu
      brightnessctl
      brillo
      dbus   # make dbus-update-activation-environment available in the path
      dmenu
      dracula-theme # gtk theme
      ffmpeg
      firefox-wayland
      flameshot
      glib # gsettings
      zenity
      grim # screenshot functionality
      i3blocks
      mako # notification system developed by swaywm maintainer
      pamixer
      playerctl
      qt5.qtwayland
      slurp # screenshot functionality
      swappy
      sway-audio-idle-inhibit
      sway-contrib.grimshot
      swayidle
      swaylock
      swaysome
      wayland
      waypipe
      wdisplays # tool to configure displays
      wf-recorder
      wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
      wofi
      xdg-utils # for opening default programs when clicking links
    ];

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };

    # xdg-desktop-portal works by exposing a series of D-Bus interfaces
    # known as portals under a well-known name
    # (org.freedesktop.portal.Desktop) and object path
    # (/org/freedesktop/portal/desktop).
    # The portal interfaces include APIs for file access, opening URIs,
    # printing and others.
    services.dbus.enable = true;
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      configPackages = [ pkgs.sway ];
      # gtk portal needed to make gtk apps happy
      # extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    services.greetd = {
      enable = true;
      settings = {
        default_session.command = "${lib.getExe pkgs.greetd.tuigreet} --time --cmd sway";
        # Autologin
        initial_session = {
          command = "sway";
          user = config.username;
        };
      };
    };

    # enable sway window manager
    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };

    security.pam.services.swaylock = {};


    # Mako systemd service.
    hm.wayland.windowManager.sway = {
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
        terminal = lib.getExe config.terminal;

        fonts = {
          names = [  "Iosevka" "FontAwesome" "Font Awesome 6 Edited" "Font Awesome 6 Brands"];
          size = 11.0;
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
         border = config.theme.primary;
         background = config.theme.primary;
         text = config.theme.background;
         indicator = config.theme.primary;
         childBorder = config.theme.primary;
       };
       colors.unfocused = {
         border = config.theme.background;
         background = config.theme.background;
         text = config.theme.foreground;
         indicator = config.theme.background;
         childBorder = config.theme.background;
       };
       colors.focusedInactive = {
         border = config.theme.background;
         background = config.theme.background;
         text = config.theme.foreground;
         indicator = config.theme.background;
         childBorder = config.theme.background;
       };
       colors.urgent = {
         border = config.theme.color5;
         background = config.theme.color5;
         text = config.theme.background;
         indicator = config.theme.color5;
         childBorder = config.theme.background;
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
        titlebar_padding 1
        default_border normal 4
        bindsym --whole-window {
          ${modifier}+button4 gaps inner current plus 5
          ${modifier}+button5 gaps inner current minus 5
        }
      '';
    };

    # Prevent locking when audio is playing
    hm.systemd.user.services."sway-audio-idle-inhibit" = {
      Unit = {
        Description = "Inhibit audio idle suspend";
        After = [ "graphical-session-pre.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Service = {
        ExecStart =
          "${pkgs.sway-audio-idle-inhibit}/bin/sway-audio-idle-inhibit";
        Restart = "on-failure";
      };

      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
}
