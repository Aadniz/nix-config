{ config, pkgs, ... }:

{
  imports = [
    #./rust.nix
    ./c.nix
  ];

  home.packages = with pkgs; [
    nodejs
    bun
    gnumake
  ];
}
