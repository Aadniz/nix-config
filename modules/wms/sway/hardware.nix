{ config, pkgs, ... }:
let
  wallpaper = ../../../wallpapers/kitan_7983.jpg;
in
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
      "*".bg = "${wallpaper} fill";
    };
  };
}
