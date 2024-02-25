{ config, pkgs, lib,  ... }:

{
  imports = [
    ./emacs
    ./rofi.nix
    ./spotify.nix
    ./kitty
    ./unison.nix
    ./discord.nix
    ./protonmail.nix
    ./jetbrains.nix
    ./obs.nix
    ./nvim.nix
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
    element-desktop
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
    #blender # blender broken?
  ];
}
