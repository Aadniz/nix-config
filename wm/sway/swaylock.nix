{ config, lib, pkgs, theme, ... }:

{
  home.packages = with pkgs; [
    config.nur.repos."999eagle".swayaudioidleinhibit
    swaylock
  ];

}
