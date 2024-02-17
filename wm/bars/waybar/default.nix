{config, pkgs, theme, ...}:
let
  mod = a: b: a - b * (builtins.div a b);
  numbers = ["一" "二" "三" "四" "五" "六" "七" "八" "九" "十"];
  genIcons = count: if count == 0 then {} else
    let
      prev = genIcons (count - 1);
      number = builtins.elemAt numbers (mod (count - 1) 10);
    in
      prev // { "${toString count}" = number; };
  waybarConfigDir = ".config/waybar";
  dateScript = "${waybarConfigDir}/scripts/date.sh";
in
{
  home.file."${dateScript}" = {
    source = ./date.sh;
    executable = true;
  };

  programs.waybar = {
    enable = true;
    systemd.enable = false;
    settings = {
      mainBar = {
        position = "top";
	layer = "top";
	modules-left = ["hyprland/workspaces"];
	modules-right = ["cpu" "memory" "pulseaudio" "clock#date" "custom/kanji-day" "clock#time"];

        "hyprland/workspaces" = {
	  disable-scroll = false;
          all-outputs = false;
	  on-scroll-up = "hyprctl dispatch workspace e-1";
          on-scroll-down = "hyprctl dispatch workspace e+1";
          format = "{icon}";
          format-icons = genIcons 40;
          persistent-workspaces = {
            "*" = 10;
          };
        };

	"clock#time" = {
          format = "{:%T}";
	  interval = 1;
	};

        "custom/kanji-day" = {
          format = "{}";
          exec = "echo '月火水木金土日' | cut -c $(( $(date +%u)*3-2 ))-$(( $(date +%u)*3 ))";
          interval = 1;
        };

	"clock#date" = {
          format = "{:%Y-%m-%d}";
	  interval = 1;
	};

        memory = {
          format = " {used}G";
          format-alt = " {used}/{total} GiB";
          interval = 30;
        };
    
        cpu = {
          format = "  {usage}%";
          format-alt = "  {avg_frequency} GHz";
          interval = 3;
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-bluetooth = "{icon}󰂰 {volume}%";
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
        font-family: "Font-Awesome-6-Edited";
	font-size: 11pt;
	background-color: ${background};
	color: ${foreground};
      }
	
      .modules-left, .modules-center, .modules-right {
        margin-left: 8px;
        margin-right: 8px;
        border-radius: 16px;
        background-color: ${third};
      }
    	
      #workspaces, #cpu, #memory, #pulseaudio, #battery, #custom-pa-mute, #custom-camera-blank, #idle_inhibitor, #tray {
        margin: 0 8px;
      }
    	
      #workspaces {
        margin-left: 0;
      }
    	
      #workspaces button, #idle_inhibitor, #custom-pa-mute, #custom-camera-blank {
        border: none;
        background-color: transparent;
        box-shadow: none;
	border-radius: 16px;
        transition: background-color 100ms ease, color 100ms ease;
        min-width: 32px;
        min-height: 32px;
        padding: 0;
        font-weight: normal;
      }

      #clock.time {
        margin: 0 8px 0 0;
      }
      #custom-kanji-day {
        padding: 8px;
	margin: 0 2px;
	background-color: ${primary};
	border-radius: 16px;
      }
      #clock.date {
        margin: 0 0 0 8px;
      }

      #custom-status-checker {
	margin: 0 0 0 -100px;
	font-stretch: ultra-condensed;
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
        background-color: ${secondary};
      }
    	
      #workspaces button:hover label {
        text-shadow: none; 
      }
    	
      #workspaces button.active {
        background-color: ${primary};
      }
    	
      #workspaces button.active:hover {
        background-color: ${color6};
      }
    	
      #workspaces button:active, #workspaces button.focused:active {
        background-color: ${foreground};
      }
    '';
  };
}
