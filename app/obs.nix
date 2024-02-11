{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    obs-studio
    obs-studio-plugins
  ];

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-gstreamer
      obs-vaapi
    ];
  };
}
