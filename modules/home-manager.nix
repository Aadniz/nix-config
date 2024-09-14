{ config, lib, pkgs, ... }:
let
  inherit (builtins) attrValues;
  inherit (lib.lists) optional;
  inherit (lib.modules) mkAliasOptionModule;
in
{
  imports =
    [
      (mkAliasOptionModule ["hm"] ["home-manager" "users" config.username])
    ];
}
