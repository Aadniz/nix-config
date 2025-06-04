{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  environment.systemPackages = with pkgs; [ sops ];

  sops = {
    defaultSopsFile = ../secrets/secrets.json;
    defaultSopsFormat = "json";
    age.keyFile = "/home/${config.username}/.config/sops/age/keys.txt";
  };
}
