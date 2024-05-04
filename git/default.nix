{ config, lib, pkgs, username, ... }:

{
  programs.git = {
    enable = true;
    userName  = "Aadniz";
    userEmail = "8147434+Aadniz@users.noreply.github.com";
    extraConfig = {
      color.ui = true;
      core.askPass = ""; # needs to be empty to use terminal for ask pass
      credential.helper = "store"; # This is not any secure at all!!
      http.postBuffer = 524288000;
      ssh.postBuffer = 524288000;
    };
  };

  # ???
  #programs.git = {
  #  enable = true;
  #  package = [pkgs.gitFull];
  #  config.credential.helper = "libsecret";
  #};

  programs.password-store.enable = true;
}
