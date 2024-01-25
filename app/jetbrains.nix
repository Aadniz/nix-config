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
    jetbrains.rust-rover
    jetbrains.pycharm-professional
  ];
}
