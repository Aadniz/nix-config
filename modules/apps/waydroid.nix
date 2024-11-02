{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    waydroid
  ];

  services.upower.enable = true;


  virtualisation = {
    waydroid.enable = true;
    lxd.enable = true;
    lxc.enable = true;
    lxc.lxcfs.enable = true;
  };
}
