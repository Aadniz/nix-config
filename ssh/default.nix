{ config, lib, pkgs, ... }:

{
  programs.ssh = {
    enable = true;

    controlMaster = "auto";
    controlPath = "${config.home.homeDirectory}/.ssh/sockets/master-%r@%n:%p";
    controlPersist = "10m";

    matchBlocks = let
      idFile = "~/.ssh/id_ed25519";
    in {
      #"gitlab.com" = {
      #  user = "git";
      #  identityFile = idFile;
      #};
      "github.com" = {
        user = "git";
        identityFile = idFile;
      };
    };
  };
}
