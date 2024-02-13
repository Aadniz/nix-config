{ config, lib, pkgs, wallpaper, ... }:

{

  home.sessionVariables = {
    "_JAVA_AWT_WM_NONREPARENTING" = "1";
    "NIXOS_OZONE_WL" = "1";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    plugins = [
    #  (pkgs.callPackage ./hyprbars.nix { inherit hyprland-plugins; } )
    ];
    settings = {
      "$mod" = "SUPER";
      exec-once = [
        "${lib.getExe pkgs.swaybg} --image ${wallpaper}"
      ];
      bind = [
        "$mod, Return, exec, ${lib.getExe pkgs.kitty}"
        "$mod, KP_Enter, exec, ${lib.getExe pkgs.kitty}"
        "$mod CTRL, Return, exec, ${lib.getExe pkgs.kitty} --class floatingKitty"
        "$mod CTRL, KP_Enter, exec, ${lib.getExe pkgs.kitty} --class floatingKitty"
        "$mod, Escape, killactive"
        "$mod, Delete, killactive"
        "$mod, q, exec, ${lib.getExe pkgs.rofi} -show drun"
        "$mod SHIFT, C, exec, hyprctl reload"
	"$mod SHIFT, Space, togglefloating"
        "$mod, Backspace, exec, ${lib.getExe pkgs.kitty}"

	# This looks super bad on hyprland
        "$mod, Q, exec, ${pkgs.rofi}/bin/rofi -show drun"

        # Moving focus
        "$mod,Left, movefocus, l"
        "$mod,Down, movefocus, d"
        "$mod,Up, movefocus, u"
        "$mod,Right, movefocus, r"
        "$mod SHIFT,Left, movewindoworgroup, l"
        "$mod SHIFT,Down, movewindoworgroup, d"
        "$mod SHIFT,Up, movewindoworgroup, u"
        "$mod SHIFT,Right, movewindoworgroup, r"
        "Alt,Tab, focuscurrentorlast"
        "$mod,Tab, cyclenext"
        #"$mod,A, focus parent"
        "$mod,Space, focuswindow, floating"


        # Scratchpad
        "$mod Shift,Minus,movetoworkspace,special"
        "$mod,Minus,togglespecialworkspace"

        # Screenshot
        '',Print,exec,wl-copy < $(${pkgs.sway-contrib.grimshot}/bin/grimshot save area "$HOME/Pictures/Shutter/Screenshot_$(date +%Y-%m-%d_%H:%M:%S).png")''
        ''SHIFT,Print,exec,${pkgs.sway-contrib.grimshot}/bin/grimshot --notify copy area''
        ''CTRL SHIFT, Print, exec,${pkgs.sway-contrib.grimshot}/bin/grimshot --notify copy output''
        ''CTRL,Print,exec,wl-copy < $(${pkgs.sway-contrib.grimshot}/bin/grimshot --notify save output "$HOME/Pictures/Shutter/Screenshot_$(date +%Y-%m-%d_%H:%M:%S).png")''
        ''$mod,Print,exec,wl-copy < $(${pkgs.sway-contrib.grimshot}/bin/grimshot --notify save screen "$HOME/Pictures/Shutter/Screenshot_$(date +%Y-%m-%d_%H:%M:%S).png")''
        ''ALT,Print,exec,wl-copy < $(${pkgs.sway-contrib.grimshot}/bin/grimshot --notify save active "$HOME/Pictures/Shutter/Screenshot_$(date +%Y-%m-%d_%H:%M:%S).png")''

	# Misc
	"$mod, W, fullscreen, 1"
        "$mod, F, fullscreen, 0"

	# Workspaces
	"$mod, 1, workspace, 1"
	"$mod, 2, workspace, 2"
	"$mod, 3, workspace, 3"
	"$mod, 4, workspace, 4"
	"$mod, 5, workspace, 5"
	"$mod, 6, workspace, 6"
	"$mod, 7, workspace, 7"
	"$mod, 8, workspace, 8"
	"$mod, 9, workspace, 9"
	"$mod, 0, workspace, 10"

	"$mod SHIFT, 1, movetoworkspace, 1"
	"$mod SHIFT, 2, movetoworkspace, 2"
	"$mod SHIFT, 3, movetoworkspace, 3"
	"$mod SHIFT, 4, movetoworkspace, 4"
	"$mod SHIFT, 5, movetoworkspace, 5"
	"$mod SHIFT, 6, movetoworkspace, 6"
	"$mod SHIFT, 7, movetoworkspace, 7"
	"$mod SHIFT, 8, movetoworkspace, 8"
	"$mod SHIFT, 9, movetoworkspace, 9"
	"$mod SHIFT, 0, movetoworkspace, 10"
      ];

      bindi = [
        # Audio
        ",XF86AudioMute,exec,${pkgs.pamixer}/bin/pamixer -t && pkill -RTMIN+1 i3blocks"
        ",XF86AudioLowerVolume,exec,${pkgs.pamixer}/bin/pamixer -d 1 && pkill -RTMIN+1 i3blocks"
        ",XF86AudioRaiseVolume,exec,${pkgs.pamixer}/bin/pamixer -i 1 && pkill -RTMIN+1 i3blocks"
        ",XF86AudioPlay,exec,${pkgs.playerctl}/bin/playerctl play-pause && pkill -RTMIN+10 i3blocks"
        ",XF86AudioNext,exec,${pkgs.playerctl}/bin/playerctl next && pkill -RTMIN+10 i3blocks"
        ",XF86AudioPrev,exec,${pkgs.playerctl}/bin/playerctl previous && pkill -RTMIN+10 i3blocks"
      ];

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        enable_swallow = true;
      };
      monitor = [
        # Middle monitor
        "DP-1,2560x1440@165Hz,2560x1440,1"
        # Left monitor
        "DP-2,2560x1440@165Hz,0x1440,1"
        # Right monitor (Not 165hz ??)
        "HDMI-A-1,highrr,5120x1440,1"
        # Top monitor
        "DP-3,3440x1440@164.999Hz,2120x0,1"
      ];
    };
    extraConfig = ''
      #exec-once = swayidle -w timeout 90 '${pkgs.gtklock}/bin/gtklock -d' timeout 210 'suspend-unless-render' resume '${pkgs.hyprland}/bin/hyprctl dispatch dpms on' before-sleep "${pkgs.gtklock}/bin/gtklock -d"
      #exec-once = swayidle -w timeout 90 '${pkgs.swaylock}/bin/swaylock -f' timeout 210 'suspend-unless-render' resume '${pkgs.hyprland}/bin/hyprctl dispatch dpms on' before-sleep "${pkgs.swaylock}/bin/swaylock -f"

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

       bind=SUPER,Y,workspaceopt,allfloat

       bind = SUPER,R,pass,^(com\.obsproject\.Studio)$
       bind = SUPERSHIFT,R,pass,^(com\.obsproject\.Studio)$

       bind=SUPERCTRL,S,exec,container-open # qutebrowser only

       bind=SUPERCTRL,R,exec,killall .waybar-wrapped && waybar & disown

       bind=SUPER,code:47,exec,fuzzel
       bind=SUPER,X,exec,fnottctl dismiss
       bind=SUPERSHIFT,X,exec,fnottctl dismiss all
       bindm=SUPER,mouse:272,movewindow
       bindm=SUPER,mouse:273,resizewindow
       bind=SUPER,T,togglefloating

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
    xwayland.enable = true;
    systemd.enable = true;
  };
}
