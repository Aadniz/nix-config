{ config, lib, pkgs, ... }:

{
  imports = [
    ./fl-studio.nix
  ];

  environment.systemPackages = with pkgs; [
    # native wayland support (unstable)
    wineWowPackages.waylandFull
  ];
}
