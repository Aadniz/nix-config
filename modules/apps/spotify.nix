{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
let
  spotify-adblock = pkgs.rustPlatform.buildRustPackage rec {
    pname = "spotify-adblock";
    version = "1.0.3";

    src = inputs.spotify-adblock;

    cargoHash = "sha256-wPV+ZY34OMbBrjmhvwjljbwmcUiPdWNHFU3ac7aVbIQ=";

    postPatch = ''
      substituteInPlace src/lib.rs \
        --replace-fail 'PathBuf::from("/etc/spotify-adblock/config.toml")' \
                       'PathBuf::from("${placeholder "out"}/etc/spotify-adblock/config.toml")'
    '';

    doCheck = false;

    postInstall = ''
      install -vD config.toml $out/etc/spotify-adblock/config.toml
    '';
  };

  package = pkgs.writers.writeBashBin "spotify" ''
    LD_PRELOAD=${spotify-adblock}/lib/libspotifyadblock.so ${lib.getExe pkgs.spotify}
  '';
in
{
  environment.systemPackages = [
    package
    (pkgs.spotify.overrideAttrs (attrs: {
      meta = attrs.meta // {
        priority = 100;
      };
    }))
  ];
}
