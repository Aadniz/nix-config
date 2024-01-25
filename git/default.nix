{ config, lib, pkgs, username, ... }:

{
  home.activation.createSshSockets = ''
    mkdir -p ${config.home.homeDirectory}/.ssh/sockets
  '';
  programs.git = {
    enable = true;
    userName  = "Aadniz";
    userEmail = "8147434+Aadniz@users.noreply.github.com";
  };

  # ???
  #programs.git = {
  #  enable = true;
  #  package = [pkgs.gitFull];
  #  config.credential.helper = "libsecret";
  #};

  programs.password-store.enable = true;
}
