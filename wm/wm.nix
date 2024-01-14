{ config, pkgs, ... }:

{
  imports = [
    ./sway/sway.nix
    ./hyprland.nix
  ];

  home.packages = with pkgs; [
    xdg-desktop-portal-gtk
  ];
}
