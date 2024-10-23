{ config, lib, pkgs, ... }:

{
  options = {
    services.i3.enable = lib.mkEnableOption "Enable i3 window manager";
    services.hyprland.enable = lib.mkEnableOption "Enable Hyprland window manager";
    services.sway.enable = lib.mkEnableOption "Enable Sway window manager";
    wms = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "What wms to have installed";
    };
  };

  config = {
    services.sway.enable = lib.elem "sway" config.wms;
    services.hyprland.enable = lib.elem "hyprland" config.wms;
    services.i3.enable = lib.elem "i3" config.wms;
  };
}
