{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./sway/default.nix
    ./hyprland/default.nix
    ./i3/default.nix
  ];

}
