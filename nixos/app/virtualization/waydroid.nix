{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    waydroid
  ];

    virtualisation.waydroid.enable = true;
}
