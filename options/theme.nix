{ config, lib, pkgs, ... }:
let
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

  themeType = lib.types.either lib.types.path (lib.types.attrsOf lib.types.str);

  getTheme = theme: if builtins.typeOf theme == "path" then
    let
      themeDerivation = pkgs.runCommand "theme.json" {} ''
        export HOME=$(pwd)
        export XDG_CACHE_HOME=$(pwd)
        export XDG_CONFIG_HOME=$(pwd)

        primaryColor=$(${dominant_colours}/bin/dominant_colours ${theme} \
            --seed ${toString seed} \
            --no-palette \
            --max-colours 1)

        ${dominant_colours}/bin/dominant_colours ${theme} \
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
          if [[ $i -ne 15 ]]; then
            echo ',' >> colors.json
          fi
        done
        echo '}' >> colors.json
        cp colors.json $out
      '';
      palette = builtins.fromJSON (builtins.readFile themeDerivation);
    in
    palette //
    {
      foreground = palette.color15;
      background = palette.color0;
    }
  else
    theme;
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
