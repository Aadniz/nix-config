{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    sway
    xdg-desktop-portal
    xdg-desktop-portal-wlr # Needed for sharing screen
  ];

  security.pam.services.swaylock = {};
}
