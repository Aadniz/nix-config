{ config, pkgs, ... }:

{
  imports = [
    ./emacs/emacs.nix
    ./rofi.nix
    ./spotify/spotify.nix
  ];

  home.packages = with pkgs; [
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
  ];
}
