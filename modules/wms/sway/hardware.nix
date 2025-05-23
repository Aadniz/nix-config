{ config, pkgs, ... }:

{
  hm.wayland.windowManager.sway.config = rec {
    input = {
      "type:keyboard" = {
        xkb_layout = "us";
        xkb_variant = "altgr-intl";
        xkb_numlock = "enabled";
        repeat_delay = "200";
        repeat_rate = "50";
      };
      "1:1:AT_Translated_Set_2_keyboard" = {
      #  xkb_options = "caps:swapescape";
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
      "1267:12736:ASUE120B:00_04F3:31C0_Touchpad" = {
        dwt = "enabled";
        tap = "enabled";
        natural_scroll = "enabled";
        middle_emulation = "false";
        scroll_factor = "1.0";
      };
      "1046:9111:Goodix_Capacitive_TouchScreen".map_to_output = "eDP-1";
    };
    output = {
      # Left monitor
      "ASUSTek COMPUTER INC VG27A M1LMQS007922" = {
        mode = "2560x1440@119.998Hz";
        position = "0 0";
      };
      # Middle monitor
      "AOC AG271QG #ASM0HnQVlo3d" = {
        mode = "2560x1440@165.000Hz";
        position = "2560 0";
      };
      # Main display
      "Samsung Display Corp. 0x4171 Unknown" = {
        mode = "2880x1800@90.001Hz";
        position = "5120 720";
        scale = "2";
      };
      # XLP's monitor
      "Hewlett Packard HP E272q CNK6281HHG" = {
        mode = "2560x1440@59.951Hz";
        position = "1440 0";
      };
      # Danulf's monitor
      "AOC AG322QWS4R4 0x00000133" = {
        mode = "2560x1440@143.912Hz";
        position = "1440 0";
      };
      # Danulf's monitor 2
      "BNQ BenQ GL2450H P4F01438019" = {
        mode = "1920x1080@60.000Hz";
        position = "4000 360";
      };
      "*".bg = "${config.theme.wallpaper} fill";
    };
  };
}
