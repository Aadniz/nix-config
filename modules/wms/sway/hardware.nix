{ config, pkgs, ... }:

{
  hm.wayland.windowManager.sway.config = rec {
    input = {
      "type:keyboard" = {
        xkb_layout = "us";
        xkb_variant = "altgr-intl";
        xkb_numlock = "enabled";
        xkb_options = "grp:win_space_toggle";
        repeat_delay = "200";
        repeat_rate = "50";
      };
      "5426:123:Razer_Razer_Viper_Ultimate_Dongle" = {
        dwt = "enabled";
        accel_profile = "flat";
        pointer_accel = "-0.1";
      };
      "5426:122:Razer_Razer_Viper_Ultimate" = {
        dwt = "enabled";
        accel_profile = "flat";
        pointer_accel = "-0.1";
      };
    };
    output = {
      # Main mini display
      "eDP-1" = {
        mode = "1200x1920@59.985Hz";
        position = "1280 1440";
        transform = "90";
        scale = "1.5";
      };
      # Extra monitor
      "AOC AG271QG " = {  # Yes that is indeed an extra space
        mode = "2560x1440@59.951Hz";
        position = "0 0";
      };
      # Right monitor
      "*".bg = "${config.theme.wallpaper} fill";
    };
  };
}
