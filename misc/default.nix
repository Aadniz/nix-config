{ config, pkgs, ... }:

{
  imports = [
    ./scripts
  ];


  home.packages = with pkgs; [
    ffmpeg
    file
    bc
    jq
    mpd
    htop
    termdown
  ];
}
