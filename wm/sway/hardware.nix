{ config, pkgs, wallpaper, ... }:

{
  wayland.windowManager.sway.config = rec {
    input = {
      "type:keyboard" = {
        xkb_layout = "us";
        xkb_variant = "altgr-intl";
        xkb_numlock = "enabled";
        xkb_options = "grp:win_space_toggle,caps:swapescape";
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
      # Middle monitor
      "AOC AG271QG #ASM0HnQVlo3d" = {
        mode = "2560x1440@165Hz";
        position = "2560,1440";
      };
      # Left monitor
      "ASUSTek COMPUTER INC ROG PG278QR #ASNuh5ktuQHd" = {
        mode = "2560x1440@165Hz";
        position = "0,1440";
      };
      # Right monitor
      "ASUSTek COMPUTER INC VG27A M1LMQS007922" = {
        mode = "2560x1440@164.999Hz";
        position = "5120,1440";
      };
      # Top monitor
      "Samsung Electric Company LC34G55T HNTW502306" = {
        mode = "3440x1440@164.999Hz";
        position = "2120,0";
      };
      "*".bg = "${wallpaper} fill";
    };
  };
}
