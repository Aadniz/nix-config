{ config, pkgs, lib,  ... }:

{
  imports = [
    ./discord.nix
    ./emacs
    ./feh
    ./jetbrains.nix
    ./kitty
    ./nemo.nix
    ./nvim
    ./obs.nix
    ./protonmail.nix
    ./rofi.nix
    ./spotify.nix
    ./unison.nix
    ./wine
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
    microsoft-edge
    godot_4
    steam
    tor-browser
    okular
    zotero  # Source finder application
    #gnome.nautilus
    insomnia  # API debugging tool
    libreoffice
    mpv
    protontricks
    deluge-gtk
    p7zip
    ark
    nicotine-plus
    kdenlive
    blender-hip
  ];
}
