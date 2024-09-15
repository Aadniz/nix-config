{ config, lib, pkgs, inputs, ... }:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  hm.imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  hm.programs.spicetify = {
    enable = true;

    enabledCustomApps = with spicePkgs.apps; [
      #lyrics-plus
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
