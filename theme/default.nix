{ username, primary ? 1, secondary ? 2, third ? 8, foreground ? 14, background ? 0 }:

let
  absColorsJsonPath = /home/${username}/.cache/wal/colors.json;
  defColorsJsonPath = ./colors.json;
  colorsJsonPath = if builtins.pathExists absColorsJsonPath then absColorsJsonPath else defColorsJsonPath;
  #pkgs.mkShell {
  #  buildInputs = [ pkgs.pywal ];
  #  shellHook = ''
  #    ${pkgs.pywal}/bin/wal -tsen -i ${wallpaper}
  #    cat ~/.cache/wal/colors.json > ${colorsJsonPath}
  #  '';
  #};
  theme = builtins.fromJSON (builtins.readFile colorsJsonPath);
  getColor = num: theme.colors."color${toString num}";
in
  theme //
  {
    primary = getColor primary;
    secondary = getColor secondary;
    third = getColor third;
    foreground = getColor foreground;
    background = getColor background;
  }
