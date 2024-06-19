{ config, pkgs, lib,  ... }:

{
  imports = [
    ./discord.nix
    ./element
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
    ./thunderbird.nix
    ./unison.nix
    ./wine
  ];

  home.packages = with pkgs; [
    R  # Calculator
    anki
    ark
    blender-hip
    chromium
    deluge-gtk
    discord-canary
    git
    godot_4
    insomnia  # API debugging tool
    kdePackages.elisa
    kdenlive
    krita
    libreoffice
    lutris
    mpv
    neofetch
    nicotine-plus
    nicotine-plus
    okular
    p7zip
    protontricks
    steam
    tor-browser
    weechat
    yazi
    zoom-us # Not pkgs.zoom
    zotero  # Source finder application
  ];
}
