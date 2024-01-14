{ config, lib, pkgs, wallpaper, ... }:
let
  colorsJsonPath = "${config.xdg.cacheHome}/wal/colors.json";
  colors = builtins.fromJSON (builtins.readFile colorsJsonPath);
in
{
  home.file.${wallpaper} = {
    onChange = ''
      ${pkgs.pywal}/bin/wal -tsen -i ${wallpaper} && cat ${colorsJsonPath}
    '';
  };
  inherit colors;
}
