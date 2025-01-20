{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    qemu
    OVMF
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

  users.groups.libvirtd.members = [ "root" "${config.username}"];
}
