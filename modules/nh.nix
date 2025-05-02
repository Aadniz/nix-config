{ config, lib, pkgs, ... }:
# https://www.youtube.com/watch?v=DnA4xNTrrqY
{
  environment.sessionVariables."NH_FLAKE" = config.flakeDir;

  environment.systemPackages = with pkgs; [
    nh
    nix-output-monitor
    nvd
  ];
}
