{ config, pkgs, ... }:

{
  wayland.windowManager.sway.config = rec {
      input = {
        "type:keyboard" = {
          xkb_layout = "no";
          xkb_numlock = "enabled";
          xkb_options = "grp:win_space_toggle";
          repeat_delay = "200";
          repeat_rate = "50";
        };
      };

      output = {
        "Virtual-1" = {
          mode = "2560x1080@50.000Hz";
          position = "0,0";
          scale = "1.0";
        };
      };
  };
}
