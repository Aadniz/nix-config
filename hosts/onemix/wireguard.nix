{ config, lib, pkgs, ... }:

{
  imports = [
    ../../modules/sops.nix
  ];

  sops.secrets."wg0_config" = {
    format = "binary";
    sopsFile = ./secrets/wg0.conf.bin;
  };

  networking.wg-quick.interfaces.wg0.configFile = config.sops.secrets."wg0_config".path;
}
