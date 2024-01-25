{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    jetbrains.clion
    jetbrains.goland
    jetbrains.idea-ultimate
    jetbrains.phpstorm
    jetbrains.rider
    jetbrains.webstorm
    jetbrains.datagrip
    #cargo
    rustup
    gcc
    jetbrains.rust-rover
    jetbrains.pycharm-professional
  ];
}
