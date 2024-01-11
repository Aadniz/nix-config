{ config, pkgs, ... }:

{
  imports = [
    ./sway/sway.nix
    ./hyprland.nix
  ];
}
