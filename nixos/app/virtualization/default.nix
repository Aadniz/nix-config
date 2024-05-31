{ config, lib, pkgs, ... }:

{
  imports = [
    ./waydroid.nix
    ./gpu-passthrough.nix
  ];

  programs.virt-manager.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    allowedBridges = [
      "nm-bridge"
      "virbr0"
    ];
    qemu.runAsRoot = false;
  };
  #boot.extraModulePackages = with config.boot.kernelPackages; [ virtualbox ];
}
