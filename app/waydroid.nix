{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    waydroid
  ];

  virtualisation.waydroid.enable = true;
}
