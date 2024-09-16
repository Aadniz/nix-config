{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./sway/default.nix
    ./hyprland/default.nix
    ./i3/default.nix
  ];

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
}
