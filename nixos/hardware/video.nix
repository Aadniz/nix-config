{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vulkan-tools
  ];

  # enable amdgpu kernel module
  boot.initrd.kernelModules = ["amdgpu"];
  services.xserver.videoDrivers = ["amdgpu"];

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = [
        pkgs.rocmPackages.clr.icd
        pkgs.rocmPackages.clr
      ];
    };
  };

  services.amdgpu-fan = {
    enable = true;
    settings = {
      speed_matrix = [
        [0 0]
        [40 60]
        [55 90]
        [60 100]
      ];
      temp_drop = 8;
    };
  };
}
