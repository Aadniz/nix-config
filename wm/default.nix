{ config, pkgs, ... }:

{
  imports = [
    ./sway
    ./hyprland.nix
  ];

  home.packages = with pkgs; [
    xdg-desktop-portal-gtk
    xdg-desktop-portal
  ];


  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = ["gtk"];
      sway.default = ["gtk" "sway"];
    };

    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
