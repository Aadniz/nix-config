{ config, lib, pkgs, ... }:

{
  # TODO: spotify adblock
  home.packages = with pkgs; [
    #spotify
    config.nur.repos.nltch.spotify-adblock
    config.nur.repos.nltch.ciscoPacketTracer8
  ];
}
