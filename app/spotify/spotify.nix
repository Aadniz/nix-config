{ config, lib, pkgs, spotify-adblock, ... }:

{
  imports = [
#    ./spotify-adblock.nix
  ];

  home.packages = with pkgs; [
    spotify
    spotify-adblock
  ];
}
