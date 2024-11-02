{ config, lib, pkgs, ... }:
let
  fl-studio-20 = (pkgs.writeShellScriptBin "fl-studio-20" ''
    WINEPREFIX="/home/${config.username}/Games/flstudio20" ${pkgs.wineWowPackages.waylandFull}/bin/wine64 "C:\\windows\\command\\start.exe" "/Unix" "/home/${config.username}/Games/flstudio20/dosdevices/c:/users/${config.username}/Start Menu/Programs/Image-Line/FL Studio 20.lnk"
  '');
in
{
  environment.systemPackages = with pkgs; [
    fl-studio-20
  ];

  hm.xdg.desktopEntries."fl-studio-20" = {
    name = "FL Studio 20";
    comment = "Digital audio workstation application by Image-Line";
    #icon = "??";
    exec = (lib.getExe fl-studio-20);
    categories = [ "Music" ];
    terminal = false;
  };
}
