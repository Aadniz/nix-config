{ username, pkgs, wallpaper, primary ? 1, secondary ? 2, third ? 8, foreground ? 14, background ? 0 }:

# TODO: want to use something more fancy than pywal

let
  wallpaperInStore = pkgs.copyPathToStore wallpaper;

  #rustPlatform = pkgs.makeRustPlatform {
  #  cargo = pkgs.rust-bin.stable.latest.minimal;
  #  rustc = pkgs.rust-bin.stable.latest.minimal;
  #};

  dominant_colours = pkgs.rustPlatform.buildRustPackage rec {
    pname = "dominant_colours";
    version = "1.1.8";

    src = pkgs.fetchFromGitHub {
      owner = "alexwlchan";
      repo = pname;
      rev = "main";
      sha256 = "kkTvIt4yc+7/sASZhyLUui/jPXoQhNy8CsqjJXn0tZU="; # replace with the actual sha256 of the repo
    };

    cargoSha256 = "eJCp1Itn0+wFigEjdlaec3cSJW9CkHRjRvA7Kp//9hU="; # replace with the actual cargoSha256

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
    ${dominant_colours}/bin/dominant_colours ${wallpaperInStore} --max-colours 16 --no-palette > colors.txt
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
