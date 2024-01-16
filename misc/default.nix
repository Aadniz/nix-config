{ config, pkgs, ... }:

{
  imports = [
  ];


  home.packages = with pkgs; [
    ffmpeg
    file
    bc
    mpd
    sway-contrib.grimshot
    termdown
    vulkan-tools
    fira-code
    font-awesome_5
  ];

}
