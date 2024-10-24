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
      "1046:9111:Goodix_Capacitive_TouchScreen".map_to_output = "eDP-1";
    };
    output = {
      # Main mini display
      "eDP-1" = {
        mode = "1200x1920@59.985Hz";
        position = "0 1440";
        transform = "90";
        scale = "1.5";
      };
      # Extra monitor
      "ASUSTek COMPUTER INC VG27A M1LMQS007922" = {
        mode = "2560x1440@59.951Hz";
        position = "0 0";
      };
      # XLP's monitor
      "Hewlett Packard HP E272q CNK6281HHG" = {
        mode = "2560x1440@59.951Hz";
        position = "0 0";
      };
      # Right monitor
      "*".bg = "${config.theme.wallpaper} fill";
    };
  };
}
