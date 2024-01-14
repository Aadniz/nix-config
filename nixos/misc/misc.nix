{ config, lib, pkgs, ... }:

{
  imports = [
    ./audio.nix
    ./netdata.nix
  ];

  environment.systemPackages = with pkgs; [
    python3
  ];
}
