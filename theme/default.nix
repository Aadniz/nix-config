{ username, pkgs, wallpaper, primary ? 1, secondary ? 2, third ? 8, foreground ? 14, background ? 0 }:

let
  wallpaperInStore = pkgs.copyPathToStore wallpaper;
  seed = 3;

  dominant_colours = pkgs.rustPlatform.buildRustPackage rec {
    name = "dominant_colours";
    #version = "1.1.8";

    src = pkgs.fetchFromGitHub {
      owner = "Aadniz";
      repo = name;
      rev = "theming";
      sha256 = "sha256-on4Wt738v6uenHsic8vEMVlKXTJHt5W2hhvVnMiGfNs=";
    };

    cargoSha256 = "lgzfMXS+Xnu1hXgQfd753P8jV/0MWxuo5hUpN2iVow8=";

    buildInputs = [ pkgs.gcc ];

    postInstall = ''
      mkdir -p $out/bin
      cp target/release-tmp/dominant_colours $out/bin/dominant_colours
    '';
  };

  themeDerivation = pkgs.runCommand "theme.json" {} ''
    export HOME=$(pwd)
    export XDG_CACHE_HOME=$(pwd)
    export XDG_CONFIG_HOME=$(pwd)
    ${dominant_colours}/bin/dominant_colours ${wallpaperInStore} \
        --seed ${toString seed} \
        --no-palette \
        --max-colours 128 \
        --max-brightness \
        --terminal-colours > colors.txt
    echo '{' > colors.json
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
  theme = builtins.fromJSON (builtins.readFile themeDerivation);
  getColor = num: theme."color${toString num}";
in
  theme //
  {
    primary = getColor primary;
    secondary = getColor secondary;
    third = getColor third;
    foreground = getColor foreground;
    background = getColor background;
  }
