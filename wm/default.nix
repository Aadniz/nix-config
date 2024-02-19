{ config, pkgs, ... }:

{
  imports = [
    ./sway
    ./hyprland
    #./pinnacle.nix
  ];

  home.packages = with pkgs; [
    remmina
    grim
    slurp
  ];
}
