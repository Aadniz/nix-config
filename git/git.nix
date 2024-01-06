{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName  = "D3faIt";
    userEmail = "8147434+D3faIt@users.noreply.github.com";
    extraConfig = {
      credential = {
        credentialStore = "secretservice";
        helper = "${ pkgs.git.override { withLibsecret = true; } }/bin/git-credential-libsecret";
      };
    };
  };
}
