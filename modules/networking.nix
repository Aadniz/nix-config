{ config, lib, pkgs, ... }:

{
  imports = [
    ../sops.nix
  ];

  sops.secrets."extra_hosts" = {
    owner = config.username;
    format = "json";
    mode = "0777";
    sopsFile = "${config.secret-dir}/secrets.json";
  };
}
