{ lib, pkgs, python3Packages, ... }:

python3Packages.buildPythonApplication rec {
  pname = "kitty-image-viewer-simplified";
  version = "1.0";

  src = pkgs.fetchFromGitHub {
    owner = "Aadniz";
    repo = pname;
    rev = "master";
    sha256 = "vbl5R854AnjCkL+RAm7ottqA1ITDiUMcxD6jRCE5LKQ=";
  };

  format = "other";

  installPhase = ''
    mkdir -p $out/bin
    cp $src/kitty-image-viewer.py $out/bin/img
    chmod +x $out/bin/img
  '';

  meta = with lib; {
    description = "Kitty image viewer wrapper written in python";
    license = licenses.mit;
  };
}
