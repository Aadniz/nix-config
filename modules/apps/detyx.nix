{ pkgs, config, ... }:

{

  imports = [
    ../sops.nix
  ];

  sops.secrets."detyx" = {
    owner = config.username;
    format = "binary";
    mode = "0511";
    sopsFile = ../../secrets/detyx.bin;
  };

  environment.systemPackages = [
    (pkgs.writeShellScriptBin "detyx" ''
      ${config.sops.secrets."detyx".path} "$@"
    '')
  ];
}
