{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs.jetbrains; [
    datagrip
    phpstorm
    pycharm-professional
  ];
}
