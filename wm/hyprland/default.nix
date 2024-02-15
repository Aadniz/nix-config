{ config, lib, pkgs, wallpaper, theme, ... }:
let
  # Function to change #rrggbb to rrggbb
  rrggbb = s: if builtins.substring 0 1 s == "#" then builtins.substring 1 (builtins.stringLength s) s else s;


in
{
  imports = [
    #../bars/hybridbar.nix  # Did not get this to work
    #../bars/eww  # too much for what I need
    ../bars/waybar
  ];

  home.packages = with pkgs; [
    xdg-desktop-portal-wlr
    xdg-desktop-portal-hyprland
  ];

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
      general = {
        layout = "dwindle";
        cursor_inactive_timeout = 30;
        border_size = 4;
        no_cursor_warps = false;
        "col.active_border" = "0xff${rrggbb theme.primary}";
        "col.inactive_border" = "0xff${rrggbb theme.background}";
        resize_on_border = true;
        gaps_in = 0;
        gaps_out = 0;
      };
      exec-once = [
        "${lib.getExe pkgs.swaybg} --image ${wallpaper} --mode fill"
        "${lib.getExe pkgs.waybar}"
      ];
      input = {
        numlock_by_default = true;
	# Ja her snakker vi norsk ja
        kb_layout = "no";
	# I actually really like this
        kb_options = "caps:escape";
        repeat_delay = 200;
        repeat_rate = 50;
        accel_profile = "flat";
        follow_mouse = true;
      };
      bind = [
        "$mod, Return, exec, ${lib.getExe pkgs.kitty}"
        "$mod, KP_Enter, exec, ${lib.getExe pkgs.kitty}"
        "$mod CTRL, Return, exec, ${lib.getExe pkgs.kitty} --class floatingKitty"
        "$mod CTRL, KP_Enter, exec, ${lib.getExe pkgs.kitty} --class floatingKitty"
        "$mod, Escape, killactive"
        "$mod, Delete, killactive"
        "$mod, q, exec, ${lib.getExe pkgs.rofi} -show drun"
        "$mod SHIFT, C, exec, hyprctl reload"
	"$mod, Space, togglefloating"
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
        "$mod, D, focuswindow, floating"


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
        "$mod, X, layoutmsg, togglesplit"
        "$mod, V, layoutmsg, preselect r"
        "$mod, C, layoutmsg, preselect d"

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
       decoration = {
         rounding = 0;
         inactive_opacity = 0.99;
         blur = {
           enabled = true;
           size = 5;
           passes = 2;
           ignore_opacity = true;
           contrast = 1.17;
           brightness = 0.8;
         };
       };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
        no_gaps_when_only = 1;
      };
       
      master = {
        no_gaps_when_only = 1;
        mfact = 0.55;
        new_is_master = true;
        new_on_top = true;
        orientation = "left";
        inherit_fullscreen = true;
        always_center_master = true;
        special_scale_factor = 0.95;
      };
      animations = {
        enabled = true;
        animation = [
          "windows, 1, 3, md3_decel, popin 60%"
          "border, 1, 10, default"
          "workspaces, 1, 7, fluent_decel, slide"
          "specialWorkspace, 1, 3, md3_decel, slidevert"
        ];
        bezier = [
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "fluent_decel, 0.1, 1, 0, 1"
        ];
      };
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        enable_swallow = true;
      };
    };
    extraConfig = ''
      # Leftover config that hasn't been sqeezed out yet

      #exec-once = swayidle -w timeout 90 '${pkgs.gtklock}/bin/gtklock -d' timeout 210 'suspend-unless-render' resume '${pkgs.hyprland}/bin/hyprctl dispatch dpms on' before-sleep "${pkgs.gtklock}/bin/gtklock -d"
      #exec-once = swayidle -w timeout 90 '${pkgs.swaylock}/bin/swaylock -f' timeout 210 'suspend-unless-render' resume '${pkgs.hyprland}/bin/hyprctl dispatch dpms on' before-sleep "${pkgs.swaylock}/bin/swaylock -f"


       bind=SUPER,Y,workspaceopt,allfloat

       bind=SUPERCTRL,R,exec,killall .waybar-wrapped && waybar & disown

       bindm=SUPER,mouse:272,movewindow
       bindm=SUPER,mouse:273,resizewindow

       bind=SUPERSHIFT,S,exec,swaylock & sleep 1 && systemctl suspend
       bind=SUPERCTRL,L,exec,swaylock

       $scratchpadsize = size 80% 85%
       $scratchpad = class:^(scratchpad)$

       windowrulev2 = float, class:floatingKitty
       windowrulev2 = float,$scratchpad
       windowrulev2 = $scratchpadsize,$scratchpad
       windowrulev2 = workspace special silent,$scratchpad
       windowrulev2 = center,$scratchpad
       windowrulev2 = opacity 0.75,class:^(org.gnome.Nautilus)$

       layerrule = blur,waybar

       bind=SUPERCTRL,right,workspace,+1
       bind=SUPERCTRL,left,workspace,-1

       xwayland {
         force_zero_scaling = true
       }

       env = QT_QPA_PLATFORMTHEME,qt5ct


       misc {
         mouse_move_enables_dpms = false
       }

    '';
    xwayland.enable = true;

    # Using exec-once instead to contain it within this module a bit more
    #systemd.enable = true;
  };
}
