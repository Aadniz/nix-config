{ config, pkgs, ... }:

{
  imports = [
  ];


  home.packages = with pkgs; [
    ffmpeg
  ];
}
