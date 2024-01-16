{ config, lib, pkgs, ... }:

{
  imports = [
    ./audio.nix
    ./netdata.nix
    ./dunst.nix
  ];

  environment.systemPackages = with pkgs; [
    python3
  ];
}
