{ config, pkgs, lib,  ... }:

{
  imports = [
    ./discord.nix
    ./emacs
    ./jetbrains.nix
    ./kitty
    ./lutris
    ./nvim
    ./obs.nix
    ./protonmail.nix
    ./rofi.nix
    ./spotify.nix
    ./unison.nix
  ];

  home.packages = with pkgs; [
    R  # Calculator
    git
    gotop
    btop
    elisa
    zoom-us # Not pkgs.zoom
    krita
    chromium
    neofetch
    discord-canary
    (element-desktop.override (_: {
      electron = pkgs.electron-bin;  # White screen issue on official pkgs
    }))
    microsoft-edge-dev
    godot_4
    steam
    tor-browser
    okular
    zotero  # Source finder application
    gnome.nautilus
    insomnia  # API debugging tool
    feh
    libreoffice
    protontricks
    deluge-gtk
    p7zip
    ark
    nicotine-plus
    kdenlive
    blender
  ];
}
