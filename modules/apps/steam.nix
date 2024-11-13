{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
   steam
  ];

  hardware.opengl = {
    ## radv: an open-source Vulkan driver from freedesktop
    driSupport32Bit = true;

    ## amdvlk: an open-source Vulkan driver from AMD
    extraPackages = [ pkgs.amdvlk ];
    extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
  };
}
