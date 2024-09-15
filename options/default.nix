# Nix file that sets up the recepie for valid options

{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ./theme.nix
    ./wms.nix
  ];

  options = {
    username = lib.mkOption {
      type = lib.types.str;
      default = "chiya";
      description = "The username of the user";
    };

    nickname = lib.mkOption {
      type = lib.types.str;
      default = "千屋";
      description = "The nickname of the user";
    };

    hostname = lib.mkOption {
      type = lib.types.str;
      default = "nix";
      description = "The hostname of the machine";
    };

    terminal = lib.mkOption {
      type = lib.types.package;
      default = pkgs.kitty;
      description = "The terminal emulator to use";
    };

    flakeDir = lib.mkOption {
      type = lib.types.str;
      default = "/home/${config.username}/.dotfiles";
      description = "The directory of the flake";
    };

    trustedHosts = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "List of authorized keys";
    };
  };
}
