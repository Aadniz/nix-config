{ config, pkgs, ... }:

{
  imports = [
    ./sway
    ./hyprland
    #./pinnacle.nix
  ];

  home.packages = with pkgs; [
    xdg-desktop-portal-gtk
    xdg-desktop-portal
    remmina
  ];


  xdg.portal = {
    enable = true;
    config.wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
