{ config, lib, pkgs, username, ... }:

{
  home.activation.createSshSockets = ''
    mkdir -p ${config.home.homeDirectory}/.ssh/sockets
  '';
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

  programs.password-store.enable = true;
}
