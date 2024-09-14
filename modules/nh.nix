{ config, lib, pkgs, ... }:
# https://www.youtube.com/watch?v=DnA4xNTrrqY
{
  environment.sessionVariables."FLAKE" = config.flakeDir;

  environment.systemPackages = with pkgs; [
    nh
    nix-output-monitor
    nvd
  ];
}
