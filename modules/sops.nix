{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];


  sops = {
    defaultSopsFile = ../secrets/secrets.json;
    defaultSopsFormat = "json";
    age.keyFile = "/home/${config.username}/.config/sops/age/keys.txt";
    #secrets = {
    #  "matrix-registration-shared-secret-yaml" = { owner = "matrix-synapse"; };
    #  "matrix-turn-shared-secret-yaml" = { owner = "matrix-synapse"; };
    #};
  };
}
