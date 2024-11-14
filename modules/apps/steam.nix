{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    steam
  ];

  hardware.graphics = {

    ## radv: an open-source Vulkan driver from freedesktop
    enable32Bit = true;

    ## amdvlk: an open-source Vulkan driver from AMD
    extraPackages = [ pkgs.amdvlk ];
    extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
  };
}
