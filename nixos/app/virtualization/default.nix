{ config, lib, pkgs, ... }:

{
  imports = [
    ./waydroid.nix
    ./gpu-passthrough.nix
  ];

  environment.systemPackages = with pkgs; [
    virt-manager
    virtualbox
    distrobox
  ];
  virtualisation.libvirtd = {
    allowedBridges = [
      "nm-bridge"
      "virbr0"
    ];
    enable = true;
    qemu.runAsRoot = false;
  };
  boot.extraModulePackages = with config.boot.kernelPackages; [ virtualbox ];
}
