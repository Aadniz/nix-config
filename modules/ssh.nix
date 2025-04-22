{ config, lib, pkgs, ... }:

{
  # SSH server
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
  };

  users.users."${config.username}".openssh.authorizedKeys.keys = config.trustedHosts;


  # SSH Client
  imports = [
    ./sops.nix
  ];

  sops.secrets."ssh_config" = {
    owner = config.username;
    format = "binary";
    mode = "0444";
    sopsFile = ../secrets/ssh_config.bin;
  };

  hm.programs.ssh = {
    enable = true;
    serverAliveInterval = 120;
    matchBlocks = let
      idFile = "~/.ssh/id_ed25519";
    in {
      "codeberg.org" = {
        user = "git";
        identityFile = idFile;
      };
      "github.com" = {
        user = "git";
        identityFile = idFile;
      };
    };
    includes = [ config.sops.secrets."ssh_config".path ];
  };
}
