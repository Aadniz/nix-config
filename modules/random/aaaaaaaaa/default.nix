{ config, lib, pkgs, ... }:

let
  aaaaaaaaaPackage = pkgs.fetchFromGitHub {
      owner = "mekaem";
      repo = "AAAAAAAAA";
      rev = "f39adbc634616c4e695bf585974c185f2eba6b67";
      sha256 = "blWLxI5XKkGdOIUe6oxt/YtYWvSlqfEZ5KsUesf3KGo=";
  };
  aaaaaaaaa = pkgs.rustPlatform.buildRustPackage rec {
    name = "AAAAAAAAA";
    src = aaaaaaaaaPackage;
    postPatch = ''
        ln -s ${./Cargo.lock} Cargo.lock
      '';
    cargoLock.lockFile = ./Cargo.lock;
    postInstall = ''
      ls -alh target/release-tmp
      mkdir -p $out/bin
      cp target/release-tmp/AAAAAAAAA $out/bin/aaaaaaaaa
    '';
  };
in
{
  environment.systemPackages = [ aaaaaaaaa ];
}
