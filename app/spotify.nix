{ config, lib, pkgs, spotify-adblock, ... }:

{
  # TODO: spotify adblock
  home.packages = with pkgs; [
    spotify
  ];
}
