{ username, pkgs, wallpaper, primary ? 1, secondary ? 2, third ? 8, foreground ? 14, background ? 0 }:

# TODO: want to use something more fancy than pywal

let
  wallpaperInStore = pkgs.copyPathToStore wallpaper;

  #rustPlatform = pkgs.makeRustPlatform {
  #  cargo = pkgs.rust-bin.stable.latest.minimal;
  #  rustc = pkgs.rust-bin.stable.latest.minimal;
  #};

  dominant_colours = pkgs.rustPlatform.buildRustPackage rec {
    name = "dominant_colours";
    #version = "1.1.8";

    src = pkgs.fetchFromGitHub {
      owner = "Aadniz";
      repo = name;
      rev = "theming";
      sha256 = "i2RKUdLn5oxBvoaOpyfoZ6yruN3ca48IBq/shJaJmIY=";
    };

    cargoSha256 = "MRzsxv8FsNyVbmOXZpoV0dPTLE5gX7msd1D/5Kqo8Sg=";

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
    ${dominant_colours}/bin/dominant_colours ${wallpaperInStore} --terminal-colours --seed 9 --no-palette --max-brightness > colors.txt
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
