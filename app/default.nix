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
    R
    git
    gotop
    obs-studio
    # OBS Studio plugin that allows you to screen capture on wlroots based wayland compositors
    obs-studio-plugins.wlrobs
    # Audio device and application capture for OBS Studio using PipeWire
    obs-studio-plugins.obs-pipewire-audio-capture
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
  ];
}
