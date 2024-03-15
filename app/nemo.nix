{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    cinnamon.nemo-with-extensions
  ];

  xdg.desktopEntries."nemo" = {
    name = "Nemo";
    comment = "File manager of the Cinnamon desktop environment";
    #icon = "??";
    exec = (lib.getExe pkgs.cinnamon.nemo-with-extensions);
    categories = [ "FileManager" ];
    terminal = false;
  };
}
