{ config, pkgs, lib,  ... }:

{
  imports = [
    ./discord.nix
    ./emacs
    ./feh
    ./kitty
    ./nemo.nix
    ./nvim
    ./obs.nix
    ./protonmail.nix
    ./thunderbird.nix
    ./rofi.nix
    ./spotify.nix
    ./unison.nix
    ./wine
#    ./jetbrains.nix  # Just doesn't work well with nixos
  ];

  home.packages = with pkgs; [
    #gnome.nautilus
    R  # Calculator
    ark
    blender-hip
    chromium
    deluge-gtk
    discord-canary
    element-desktop
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
