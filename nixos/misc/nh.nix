{ config, lib, pkgs, dotfilesDir, ... }:
# https://www.youtube.com/watch?v=DnA4xNTrrqY
{
  environment.sessionVariables."FLAKE" = dotfilesDir;

  environment.systemPackages = with pkgs; [
    nh
    nix-output-monitor
    nvd
  ];
}
