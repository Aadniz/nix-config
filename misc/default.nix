{ config, pkgs, ... }:

{
  imports = [
  ];


  home.packages = with pkgs; [
    ffmpeg
    file
    sway-contrib.grimshot
    termdown
    vulkan-tools
  ];
}
