{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName  = "D3faIt";
    userEmail = "8147434+D3faIt@users.noreply.github.com";
  };

  # ???
  #programs.git = {
  #  enable = true;
  #  package = [pkgs.gitFull];
  #  config.credential.helper = "libsecret";
  #};
  programs.ssh = {
    enable = true;

    controlMaster = "auto";
    controlPath = "~/.ssh/sockets/master-%r@%n:%p";
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

  programs.password-store.enable = true;
}
