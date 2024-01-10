{ config, lib, pkgs, ... }:

{

  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
    #  (pkgs.callPackage ./hyprbars.nix { inherit hyprland-plugins; } )
    ];
    settings = { };
    extraConfig = ''
      exec-once = dbus-update-activation-environment DISPLAY XAUTHORITY WAYLAND_DISPLAY

      exec-once = hyprprofile Personal

      exec-once = pypr
      exec-once = ydotoold
      exec-once = STEAM_FRAME_FORCE_CLOSE=1 steam -silent
      exec-once = nm-applet
      exec-once = blueman-applet
      exec-once = GOMAXPROCS=1 syncthing --no-browser
      exec-once = protonmail-bridge --noninteractive
      exec-once = waybar
      exec-once = emacs --daemon

      #exec-once = swayidle -w timeout 90 '${pkgs.gtklock}/bin/gtklock -d' timeout 210 'suspend-unless-render' resume '${pkgs.hyprland}/bin/hyprctl dispatch dpms on' before-sleep "${pkgs.gtklock}/bin/gtklock -d"
      #exec-once = swayidle -w timeout 90 '${pkgs.swaylock}/bin/swaylock -f' timeout 210 'suspend-unless-render' resume '${pkgs.hyprland}/bin/hyprctl dispatch dpms on' before-sleep "${pkgs.swaylock}/bin/swaylock -f"
      exec-once = obs-notification-mute-daemon

      exec = ~/.swaybg-stylix

      general {
        layout = master
        cursor_inactive_timeout = 30
        border_size = 4
        no_cursor_warps = false
        col.active_border = 0xff454545

        col.inactive_border = 0x33454545

            resize_on_border = true
            gaps_in = 7
            gaps_out = 7
       }

       bind=SUPER,SPACE,fullscreen,1
       bind=ALT,TAB,cyclenext
       bind=ALT,TAB,bringactivetotop
       bind=ALTSHIFT,TAB,cyclenext,prev
       bind=ALTSHIFT,TAB,bringactivetotop
       bind=SUPER,Y,workspaceopt,allfloat

       bind = SUPER,R,pass,^(com\.obsproject\.Studio)$
       bind = SUPERSHIFT,R,pass,^(com\.obsproject\.Studio)$

       bind=SUPER,RETURN,exec,kitty

       bind=SUPERCTRL,S,exec,container-open # qutebrowser only

       bind=SUPERCTRL,R,exec,killall .waybar-wrapped && waybar & disown

       bind=SUPER,code:47,exec,fuzzel
       bind=SUPER,X,exec,fnottctl dismiss
       bind=SUPERSHIFT,X,exec,fnottctl dismiss all
       bind=SUPER,Q,killactive
       bind=SUPERSHIFT,Q,exit
       bindm=SUPER,mouse:272,movewindow
       bindm=SUPER,mouse:273,resizewindow
       bind=SUPER,T,togglefloating

       bind=,code:107,exec,grim -g "$(slurp)"
       bind=SHIFT,code:107,exec,grim -g "$(slurp -o)"
       bind=SUPER,code:107,exec,grim
       bind=CTRL,code:107,exec,grim -g "$(slurp)" - | wl-copy
       bind=SHIFTCTRL,code:107,exec,grim -g "$(slurp -o)" - | wl-copy
       bind=SUPERCTRL,code:107,exec,grim - | wl-copy

       bind=,code:122,exec,pamixer -d 10
       bind=,code:123,exec,pamixer -i 10
       bind=,code:121,exec,pamixer -t
       bind=,code:256,exec,pamixer --default-source -t
       bind=SHIFT,code:122,exec,pamixer --default-source -d 10
       bind=SHIFT,code:123,exec,pamixer --default-source -i 10
       bind=,code:232,exec,brightnessctl set 15-
       bind=,code:233,exec,brightnessctl set +15
       bind=,code:237,exec,brightnessctl --device='asus::kbd_backlight' set 1-
       bind=,code:238,exec,brightnessctl --device='asus::kbd_backlight' set +1
       bind=,code:255,exec,airplane-mode

       bind=SUPERSHIFT,S,exec,swaylock & sleep 1 && systemctl suspend
       bind=SUPERCTRL,L,exec,swaylock

       bind=SUPER,H,movefocus,l
       bind=SUPER,J,movefocus,d
       bind=SUPER,K,movefocus,u
       bind=SUPER,L,movefocus,r

       bind=SUPERSHIFT,H,movewindow,l
       bind=SUPERSHIFT,J,movewindow,d
       bind=SUPERSHIFT,K,movewindow,u
       bind=SUPERSHIFT,L,movewindow,r

       bind=SUPER,1,exec,hyprworkspace 1
       bind=SUPER,2,exec,hyprworkspace 2
       bind=SUPER,3,exec,hyprworkspace 3
       bind=SUPER,4,exec,hyprworkspace 4
       bind=SUPER,5,exec,hyprworkspace 5
       bind=SUPER,6,exec,hyprworkspace 6
       bind=SUPER,7,exec,hyprworkspace 7
       bind=SUPER,8,exec,hyprworkspace 8
       bind=SUPER,9,exec,hyprworkspace 9

       bind=SUPERSHIFT,1,movetoworkspace,1
       bind=SUPERSHIFT,2,movetoworkspace,2
       bind=SUPERSHIFT,3,movetoworkspace,3
       bind=SUPERSHIFT,4,movetoworkspace,4
       bind=SUPERSHIFT,5,movetoworkspace,5
       bind=SUPERSHIFT,6,movetoworkspace,6
       bind=SUPERSHIFT,7,movetoworkspace,7
       bind=SUPERSHIFT,8,movetoworkspace,8
       bind=SUPERSHIFT,9,movetoworkspace,9

       bind=SUPER,Z,exec,pypr toggle term && hyprctl dispatch bringactivetotop
       bind=SUPER,F,exec,pypr toggle ranger && hyprctl dispatch bringactivetotop
       bind=SUPER,N,exec,pypr toggle musikcube && hyprctl dispatch bringactivetotop
       bind=SUPER,B,exec,pypr toggle btm && hyprctl dispatch bringactivetotop
       bind=SUPER,E,exec,pypr toggle geary && hyprctl dispatch bringactivetotop
       bind=SUPER,code:172,exec,pypr toggle pavucontrol && hyprctl dispatch bringactivetotop
       $scratchpadsize = size 80% 85%

       $scratchpad = class:^(scratchpad)$
       windowrulev2 = float,$scratchpad
       windowrulev2 = $scratchpadsize,$scratchpad
       windowrulev2 = workspace special silent,$scratchpad
       windowrulev2 = center,$scratchpad

       $gearyscratchpad = class:^(geary)$
       windowrulev2 = float,$gearyscratchpad
       windowrulev2 = $scratchpadsize,$gearyscratchpad
       windowrulev2 = workspace special silent,$gearyscratchpad
       windowrulev2 = center,$gearyscratchpad

       $pavucontrol = class:^(pavucontrol)$
       windowrulev2 = float,$pavucontrol
       windowrulev2 = size 86% 40%,$pavucontrol
       windowrulev2 = move 50% 6%,$pavucontrol
       windowrulev2 = workspace special silent,$pavucontrol
       windowrulev2 = opacity 0.80,$pavucontrol

       windowrulev2 = float,title:^(Kdenlive)$

       windowrulev2 = float,class:^(pokefinder)$

       windowrulev2 = opacity 0.85,$gearyscratchpad
       windowrulev2 = opacity 0.80,title:ORUI
       windowrulev2 = opacity 0.80,title:Heimdall
       windowrulev2 = opacity 0.80,title:^(LibreWolf)$
       windowrulev2 = opacity 0.80,title:^(New Tab - LibreWolf)$
       windowrulev2 = opacity 0.80,title:^(New Tab - Brave)$
       windowrulev2 = opacity 0.65,title:^(My Local Dashboard Awesome Homepage - qutebrowser)$
       windowrulev2 = opacity 0.65,title:\[.*\] - My Local Dashboard Awesome Homepage
       windowrulev2 = opacity 0.9,class:^(org.keepassxc.KeePassXC)$
       windowrulev2 = opacity 0.75,class:^(org.gnome.Nautilus)$

       layerrule = blur,waybar

       bind=SUPER,code:21,exec,pypr zoom
       bind=SUPER,code:21,exec,hyprctl reload

       bind=SUPERCTRL,right,workspace,+1
       bind=SUPERCTRL,left,workspace,-1

       bind=SUPER,I,exec,networkmanager_dmenu
       bind=SUPER,P,exec,keepmenu
       bind=SUPERSHIFT,P,exec,hyprprofile-dmenu

       #monitor=eDP-1,1920x1080,1000x1200,1
       #monitor=HDMI-A-1,1920x1200,1920x0,1
       #monitor=DP-1,1920x1200,0x0,1
       monitor=Virtual-1, 2560x1080, 0x0, 1

       xwayland {
         force_zero_scaling = true
       }

       env = WLR_DRM_DEVICES,/dev/dri/card1:/dev/dri/card0
       env = QT_QPA_PLATFORMTHEME,qt5ct

       input {
         kb_layout = no
         kb_options = caps:escape
         repeat_delay = 200
         repeat_rate = 50
         accel_profile = flat
         follow_mouse = 2
       }

       misc {
         mouse_move_enables_dpms = false
       }
       decoration {
         rounding = 8
         blur {
           enabled = true
           size = 5
           passes = 2
           ignore_opacity = true
           contrast = 1.17
           brightness = 0.8
         }
       }

    '';
    xwayland = { enable = true; };
    systemd.enable = true;
  };
}
