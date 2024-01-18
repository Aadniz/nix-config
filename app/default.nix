{ config, pkgs, lib,  ... }:

{
  imports = [
    ./emacs
    ./rofi.nix
    ./spotify.nix
    ./kitty.nix
  ];

  home.packages = with pkgs; [
    R
    git
    gotop
    obs-studio
    btop
    elisa
    zoom-us # Not pkgs.zoom
    krita
    chromium
    neofetch
    discord
    discord-canary
    element-desktop
    microsoft-edge-dev
    godot_4
    steam
  ];
}
