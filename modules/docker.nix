{ config, lib, pkgs, ... }:

{
  virtualisation.docker.enable = true;
  users.users.${config.username}.extraGroups = [ "docker" ];
}
