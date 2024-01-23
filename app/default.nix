{ config, pkgs, lib,  ... }:

{
  imports = [
    ./emacs
    ./rofi.nix
    ./spotify.nix
    ./kitty.nix
    ./unison.nix
    ./discord.nix
    ./protonmail.nix
  ];

  home.packages = with pkgs; [
    R  # Calculator
    git
    gotop
    obs-studio
    btop
    elisa
    zoom-us # Not pkgs.zoom
    krita
    chromium
    neofetch
    discord-canary
    element-desktop
    microsoft-edge-dev
    godot_4
    steam
    tor-browser
    okular
    zotero  # Source finder application
    insomnia  # API debugging tool
    neovim
  ];
}
