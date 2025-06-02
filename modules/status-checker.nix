{ config, lib, pkgs, ... }:

let

  # NOTE this goes outside the scope of the repo (because this is private)
  # If this file doesn't exist, the systemd service won't run (ConditionPathExists takes care of that)
  settingsPath = "/home/${config.username}/Dev/python/status-commands/settings.json";

  statusPackage = pkgs.fetchFromGitHub {
      owner = "Aadniz";
      repo = "status";
      rev = "a3177fccf177fd11f48eae0882959b2c4294fec3";
      sha256 = "umLBUU6QyDay97+sVXlN49Q09nwmtVnR+KTiN6XAQw0=";
  };
  statusChecker = pkgs.rustPlatform.buildRustPackage rec {
    name = "status";
    src = statusPackage;
    cargoHash = "sha256-fXxbt2gG24zx6B+Bc0F6pCWqyUgSvNT2XAQuWy4WpFA=";
    postInstall = ''
      ls target/release-tmp
      mkdir -p $out/bin
      cp target/release-tmp/status $out/bin/status-checker
    '';
  };
  status = pkgs.stdenv.mkDerivation rec {
    pname = "status";
    version = "0.1.0";
    src = statusPackage;
    nativeBuildInputs = [ pkgs.makeWrapper ];
    buildInputs = with pkgs.python3Packages; [ pyzmq ];
    installPhase = ''
      mkdir -p $out/bin
      cp -r ./daemon/* $out/
      mv $out/main.py $out/bin/status
      wrapProgram $out/bin/status \
        --prefix PYTHONPATH : $PYTHONPATH
    '';
  };
in
{
  systemd.services.status-checker = {
    description = "Checking all servers, test application written in rust";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    unitConfig.ConditionPathExists = settingsPath;
    serviceConfig = {
      ExecStart = "${statusChecker}/bin/status-checker ${settingsPath}";
      Restart = "always";
      User = config.username;
    };
  };
  environment.systemPackages = [ status ];
}
