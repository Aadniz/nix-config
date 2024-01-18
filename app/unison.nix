{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    unison
  ];

  services.unison = {
    enable = true;
    pairs = {
      "org-files" = {
        roots = [ "${config.home.homeDirectory}/Documents/org" "ssh://backup//raid/backup/unison/org-notes"];
        commandOptions = {
          batch = "true";
          ui = "text";
          prefer = "newer";
        };
      };
    };
  };
}
