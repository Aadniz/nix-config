{ config, pkgs, ... }:

{
  imports = [
    ./sway
    ./hyprland.nix
  ];

  home.packages = with pkgs; [
    xdg-desktop-portal-gtk
  ];
}
