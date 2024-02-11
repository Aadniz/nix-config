{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    #obs-studio
  ];

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-gstreamer
      obs-vaapi
    ];
  };
}
