{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    R
    libqalculate
  ];
}
