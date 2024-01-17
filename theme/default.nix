{ username, pkgs, wallpaper, primary ? 1, secondary ? 2, third ? 8, foreground ? 14, background ? 0 }:

let
  wallpaperInStore = pkgs.copyPathToStore wallpaper; # ../wallpaper.jpg;
  themeDerivation = pkgs.runCommand "theme.json" {} ''
    export HOME=$(pwd)
    export XDG_CACHE_HOME=$(pwd)
    export XDG_CONFIG_HOME=$(pwd)
    ${pkgs.pywal}/bin/wal -i ${wallpaperInStore} --saturate 0.45
    ${pkgs.jq}/bin/jq 'del(.wallpaper)' $HOME/.cache/wal/colors.json > colors.json
    cp colors.json $out
  '';

  theme = builtins.fromJSON (builtins.readFile themeDerivation);
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
