{ config, lib, pkgs, inputs, ... }:

let
  pinnacleSrc = inputs.pinnacle;
  pinnacle = pkgs.stdenv.mkDerivation {
    name = "pinnacle";
    src = pinnacleSrc;
    buildInputs = [ pkgs.cargo ];
    buildPhase = ''
      cargo build --release
    '';
    installPhase = ''
      install -D target/release/pinnacle $out/bin/pinnacle
    '';
  };
in
{
  environment.systemPackages = with pkgs; [
    #pinnacle
  ];
}
