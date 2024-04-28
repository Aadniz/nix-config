{ config, pkgs, lib,  ... }:

{
  imports = [
    ./discord.nix
    ./emacs
    ./feh
#    ./jetbrains.nix  # Just doesn't work well with nixos
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
    #gnome.nautilus
    R  # Calculator
    ark
    blender-hip
    btop
    chromium
    deluge-gtk
    discord-canary
    element-desktop
    git
    godot_4
    gotop
    insomnia  # API debugging tool
    kdePackages.elisa
    kdenlive
    krita
    libreoffice
    microsoft-edge
    mpv
    neofetch
    nicotine-plus
    okular
    p7zip
    protontricks
    steam
    tor-browser
    yazi
    zoom-us # Not pkgs.zoom
    zotero  # Source finder application
  ];
}
