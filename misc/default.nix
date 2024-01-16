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
    sway-contrib.grimshot
    termdown
    vulkan-tools
    fira-code
    font-awesome_5
  ];
}
