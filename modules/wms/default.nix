{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./sway/default.nix
    ./hyprland/default.nix
    ./i3/default.nix
    ./dark-theme.nix
  ];

  # GDM default login manager
  services.displayManager.gdm.enable = true;
}
