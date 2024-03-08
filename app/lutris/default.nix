{ config, lib, pkgs, ... }:

{

  home.packages = with pkgs; [
    # native wayland support (unstable)
    wineWowPackages.waylandFull

    # FL Studio
    (pkgs.writeShellScriptBin "fl-studio-20" ''
      #!/bin/bash
      WINEPREFIX="/home/chiya/Games/flstudio20" ${pkgs.wineWowPackages.waylandFull}/bin/wine64 "C:\\windows\\command\\start.exe" "/Unix" "/home/chiya/Games/flstudio20/dosdevices/c:/users/chiya/Start Menu/Programs/Image-Line/FL Studio 20.lnk"
    '')
  ];
}
