{ config, lib, pkgs, inputs, ... }:

# https://github.com/LavaDesu/flakes/blob/ac103633d3483f2605f54c6af8c5c1478efbe062/modules/user/spicetify.nix

let
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in
{
  imports = [ inputs.spicetify-nix.homeManagerModule ];

  programs.spicetify = {
    enable = true;

    enabledCustomApps = with spicePkgs.apps; [
      lyrics-plus
    ];
    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplayMod
      shuffle
      hidePodcasts
      adblock

      skipStats
      songStats
      history
      volumePercentage
    ];
  };
}
