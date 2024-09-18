# options/theme.nix
{ config, lib, pkgs, ... }:
let
  defaultTheme = {
    primary = "#FFFFFF";
    background = "#000000";
    foreground = "#FFFFFF";
    secondary = "#FF0000";
    third = "#00FF00";
    color0 = "#2E3436";
    color1 = "#CC0000";
    color2 = "#4E9A06";
    color3 = "#C4A000";
    color4 = "#3465A4";
    color5 = "#75507B";
    color6 = "#06989A";
    color7 = "#D3D7CF";
    color8 = "#555753";
    color9 = "#EF2929";
    color10 = "#8AE234";
    color11 = "#FCE94F";
    color12 = "#729FCF";
    color13 = "#AD7FA8";
    color14 = "#34E2E2";
    color15 = "#EEEEEC";
  };

  seed = 3;

  dominant_colours = pkgs.rustPlatform.buildRustPackage rec {
    name = "dominant_colours";
    #version = "1.1.8";

    src = pkgs.fetchFromGitHub {
      owner = "Aadniz";
      repo = name;
      rev = "theming";
      sha256 = "on4Wt738v6uenHsic8vEMVlKXTJHt5W2hhvVnMiGfNs=";
    };

    cargoSha256 = "lgzfMXS+Xnu1hXgQfd753P8jV/0MWxuo5hUpN2iVow8=";

    buildInputs = [ pkgs.gcc ];

    postInstall = ''
      mkdir -p $out/bin
      cp target/release-tmp/dominant_colours $out/bin/dominant_colours
    '';
  };

  themeType = lib.types.attrsOf (lib.types.either lib.types.path lib.types.str);

  getTheme = theme: if theme ? wallpaper then
    let
      themeDerivation = pkgs.runCommand "theme.json" {} /* bash */ ''
        export HOME=$(pwd)
        export XDG_CACHE_HOME=$(pwd)
        export XDG_CONFIG_HOME=$(pwd)

        primaryColor=$(${dominant_colours}/bin/dominant_colours ${theme.wallpaper} \
            --seed ${toString seed} \
            --no-palette \
            --max-colours 1)

        ${dominant_colours}/bin/dominant_colours ${theme.wallpaper} \
            --seed ${toString seed} \
            --no-palette \
            --max-colours 128 \
            --max-brightness \
            --terminal-colours > colors.txt

        echo '{' > colors.json
        echo '"primary": "'$primaryColor'",' >> colors.json

        for i in {0..15}
        do
          echo '"color'$i'": "'$(sed -n "$((i+1))p" colors.txt)'"' >> colors.json
          if [[ $i -eq 0 ]]; then
            echo ',"background": "'$(sed -n "$((i+1))p" colors.txt)'"' >> colors.json
          fi
          if [[ $i -eq 2 ]]; then
            echo ',"secondary": "'$(sed -n "$((i+1))p" colors.txt)'"' >> colors.json
          fi
          if [[ $i -eq 3 ]]; then
            echo ',"third": "'$(sed -n "$((i+1))p" colors.txt)'"' >> colors.json
          fi
          if [[ $i -eq 15 ]]; then
            echo ',"foreground": "'$(sed -n "$((i+1))p" colors.txt)'"' >> colors.json
          fi
          if [[ $i -ne 15 ]]; then
            echo ',' >> colors.json
          fi
        done
        echo '}' >> colors.json
        cp colors.json $out
      '';
      palette = builtins.fromJSON (builtins.readFile themeDerivation);
    in
    palette // theme
  else
    defaultTheme // theme;

in
{
  options = {
    theme = lib.mkOption {
      type = themeType;
      default = {};
      description = "Theme settings or path to a file that outputs these colors";
      apply = getTheme;
    };
  };
}
