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
    element-desktop
    microsoft-edge-dev
    godot_4
  ];
}
