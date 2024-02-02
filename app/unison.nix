{ config, lib, pkgs, dotfilesDir, username, ... }:

{
  home.packages = with pkgs; [
    unison
  ];

  services.unison.enable = true;
  home.file."${config.home.homeDirectory}/.unison/org-files.prf".text = ''
    root = /home/${username}/Documents/org
    root = ssh://backup//raid/backup/unison/org-notes
    batch = true
  '';
}
