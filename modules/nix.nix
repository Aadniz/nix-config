{ config, lib, pkgs, inputs, ... }:

{
  nix.registry.n.flake = inputs.nixpkgs;
}
