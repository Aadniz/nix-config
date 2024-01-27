{ config, pkgs, ... }:

{
  imports = [
    ./scripts
    ./fcitx5.nix
  ];


  home.packages = with pkgs; [
    ffmpeg
    file
    bc
    jq
    mpd
    ibus
    htop
    termdown
  ];
}
