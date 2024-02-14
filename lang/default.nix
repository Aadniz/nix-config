{ config, pkgs, ... }:

{
  imports = [
    ./rust.nix
  ];

  home.packages = with pkgs; [
    nodejs
    bun
    gnumake
  ];
}
