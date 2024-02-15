{config, pkgs, theme, ...}:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        position = "top";
	layer = "top";
	modules-left = ["hyprland/workspaces"];
	modules-right = ["pulseaudio" "clock"];

        "hyprland/workspaces" = {
	  disable-scroll = false;
          all-outputs = false;
	  on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          format = "{icon}";
          format-icons = {
            "1" = "いち"; # this is not a material design circle like the other icons
            "2" = "に";
            "3" = "さん";
            "4" = "よん";
            "5" = "ご";
	    "6" = "ろく";
	    "7" = "なな";
	    "8" = "はち";
	    "9" = "きゅう";
	    "10" = "じゅう";
          };
        };

        clock = {
          format = "{:%Y-%m-%d %T}";
          interval = 1;
        };

        pulseaudio = {
          format = "{volume}% {icon}";
          format-bluetooth = "{volume}% {icon}󰂰";
          format-muted = "󰝟";
          format-icons = {
            headphones = "󰋋";
            handsfree = "󰋏";
            headset = "󰋎";
            phone = "󰏲";
            portable = "󰄜";
            car = "󰄍";
            default = "󰕾";
          };
          #on-click = "${termapp} ${pkgs.pulsemixer}/bin/pulsemixer";
          on-scroll-up = "${pkgs.pamixer}/bin/pamixer -ui 2 && ${pkgs.pamixer}/bin/pamixer --get-volume > $XDG_RUNTIME_DIR/wob.sock";
          on-scroll-down = "${pkgs.pamixer}/bin/pamixer -ud 2 && ${pkgs.pamixer}/bin/pamixer --get-volume > $XDG_RUNTIME_DIR/wob.sock";
          smooth-scrolling-threshold = 0.16;
        };
      };
    };

    style = with theme; /* css */ ''
      window#waybar {
        font-family: "Monocraft";
	font-size: 10pt;
	background-color: ${background};
	color: ${foreground};
      }
	
      .modules-left, .modules-center, .modules-right {
        margin-left: 8px;
        margin-right: 8px;
        border-radius: 16px;
        background-color: ${third};
      }
    	
      #workspaces, #mpd, #clock, #network, #pulseaudio, #battery, #custom-pa-mute, #custom-camera-blank, #idle_inhibitor, #tray {
        margin: 0 8px;
      }
    	
      #custom-pa-mute, #custom-camera-blank {
        margin-right: 0;
      }
    	
      #idle_inhibitor, #custom-camera-blank {
        margin-left: 0;
      }
    	
      #workspaces {
        margin-left: 0;
      }
    	
      #workspaces button, #idle_inhibitor, #custom-pa-mute, #custom-camera-blank {
        border: none;
        background-color: transparent;
        box-shadow: none;  /* dunno why this is set */
        border-radius: 16px;
        transition: background-color 100ms ease, color 100ms ease;
        min-width: 32px;
        min-height: 32px;
        padding: 0;
        font-weight: normal;
      }
    	
      #workspaces button.urgent, #idle_inhibitor.activated, #custom-pa-mute.muted, #custom-camera-blank.blank {
        background-color: ${secondary};
        color: ${third};
      }
    	
      #custom-pa-mute.muted, #custom-camera-blank.blank {
        background-color: ${color1};
      }
    
      #workspaces button:hover {
        background-image: none; /* remove Adwaita button gradient */
        background-color: ${color5};
      }
    	
      #workspaces button:hover label {
        text-shadow: none; /* Adwaita? */
      }
    	
      #workspaces button.active {
        background-color: ${primary};
        color: ${background};
      }
    	
      #workspaces button.active:hover {
        background-color: ${color6};
      }
    	
      #workspaces button:active, #workspaces button.focused:active {
        background-color: ${foreground};
        color: ${third};
      }
    '';
  };
}
