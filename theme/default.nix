{ config, lib, pkgs, wallpaper, ... }:

let
  absColorsJsonPath = "${config.xdg.cacheHome}/wal/colors.json";
  defColorsJsonPath = "./colors.json";
  colorsJsonPath = if builtins.pathExists absColorsJsonPath then absColorsJsonPath else defColorsJsonPath;
  theme = builtins.fromJSON (builtins.readFile colorsJsonPath) //
    {
      primary = theme.colors.color9;
      secondary = theme.colors.color2;
      third = theme.colors.color8;
      bright = theme.colors.color14;
      dark = theme.colors.color0;
    };
in
{
  home.file.${wallpaper} = {
    onChange = ''
      ${pkgs.pywal}/bin/wal -tsen -i ${wallpaper} && cat ${colorsJsonPath}
    '';
  };
  inherit theme;
}
