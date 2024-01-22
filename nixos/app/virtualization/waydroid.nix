{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    waydroid
  ];

  virtualisation = {
    waydroid.enable = true;
    lxd.enable = true;
    lxc.enable = true;
    lxc.lxcfs.enable = true;
  };
}
