{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vulkan-tools
  ];

  # enable amdgpu kernel module
  boot.initrd.kernelModules = ["amdgpu"];
  services.xserver.videoDrivers = ["amdgpu"];

  hardware.opengl = {
    # Mesa
    enable = true;

    # Vulkan
    driSupport = true;

    # Some other stuff?
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
      rocmPackages.clr.icd
      rocmPackages.clr
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
    setLdLibraryPath = true;
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
