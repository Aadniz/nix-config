{ config, lib, pkgs, ... }:

{
  imports = [
    ./sops.nix
  ];

  sops.secrets."hosts" = {
    owner = config.username;
    format = "binary";
    mode = "0444";
    sopsFile = ../secrets/hosts.bin;
  };

  # Secret host files
  environment.etc."hosts".source = lib.mkForce config.sops.secrets."hosts".path;
}
