{ config, pkgs, ... }:

{
  imports = [
    ./emacs
    ./rofi.nix
    ./spotify.nix
  ];

  home.packages = with pkgs; [
    R
    git
    gotop
    obs-studio
    btop
    elisa
    chromium
    neofetch
    discord
    discord-canary
    element-desktop-wayland
    microsoft-edge-dev
  ];
}
