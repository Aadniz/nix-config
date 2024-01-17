{ config, pkgs, ... }:

{
  imports = [
  ];


  home.packages = with pkgs; [
    ffmpeg
    file
    bc
    jq
    mpd
    htop
    termdown
    vulkan-tools
  ];
}
