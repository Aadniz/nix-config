{ config, lib, pkgs, ... }:

{
  imports = [
    ./fl-studio.nix
  ];

  home.packages = with pkgs; [
    # native wayland support (unstable)
    wineWowPackages.waylandFull
  ];
}
