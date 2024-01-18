{ config, lib, pkgs, ... }:

{
  imports = [
    ./video.nix
    ./disks.nix
  ];
}
