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
}
