{ config, lib, pkgs, ... }:
let
  fl-studio-20 = (pkgs.writeShellScriptBin "fl-studio-20" ''
    WINEPREFIX="/home/chiya/Games/flstudio20" ${pkgs.wineWowPackages.waylandFull}/bin/wine64 "C:\\windows\\command\\start.exe" "/Unix" "/home/chiya/Games/flstudio20/dosdevices/c:/users/chiya/Start Menu/Programs/Image-Line/FL Studio 20.lnk"
  '');
in
{
  home.packages = with pkgs; [
    fl-studio-20
  ];

  xdg.desktopEntries."fl-studio-20" = {
    name = "FL Studio 20";
    comment = "Digital audio workstation application by Image-Line";
    #icon = "??";
    exec = (lib.getExe fl-studio-20);
    categories = [ "Music" ];
    terminal = false;
  };
}
