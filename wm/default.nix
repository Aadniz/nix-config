{ config, pkgs, ... }:

# https://github.com/Stunkymonkey/nixos/blob/5f08e0654883f62cba3400536d1ebfcf106d7e72/profiles/sway/screen-sharing.nix

{
  imports = [
    ./sway
    ./hyprland.nix
  ];

  home.packages = with pkgs; [
    xdg-desktop-portal-gtk
    xdg-desktop-portal
    remmina
  ];


  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = ["gtk"];
      sway.default = ["gtk" "sway"];
      wlr.enable = true;
    };

    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
