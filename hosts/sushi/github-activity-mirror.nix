{ config, lib, pkgs, ... }:

let

  # NOTE this goes outside the scope of the repo (because this is private)
  # If this file doesn't exist, the systemd service won't run (ConditionPathExists takes care of that)
  settingsPath = "/home/${config.username}/Dev/rust/github-activity-mirror/settings.toml";

  githubActivityMirror = pkgs.rustPlatform.buildRustPackage {
    name = "github-activity-mirror";
    nativeBuildInputs = with pkgs; [ pkg-config openssl.dev ];
    PKG_CONFIG_PATH="${pkgs.openssl.dev}/lib/pkgconfig";
    src = pkgs.fetchgit {
      url = "https://codeberg.org/Aadniz/github-activity-mirror.git";
      rev = "cc0c25e614a3ea98979a20df7851e86c8468755c";
      sha256 = "sha256-PV/vfdOepPdQJgiTxCyEQnDcLbt+gX/NgC67exKIK1Q=";
    };
    cargoHash = "sha256-JwFx51ADqP1ONP4bvRL5IL8KDEH2ExY4Mb4of61+vSc=";
    postInstall = ''
      ls target/release-tmp
      mkdir -p $out/bin
      cp target/release-tmp/github-activity-mirror $out/bin/github-activity-mirror
    '';
  };
in
{
  systemd.timers.github-activity-mirror = {
    wantedBy = [ "timers.target" ];
    enable = true;
    timerConfig = {
      # Run approximately 2 times a week
      OnCalendar = "Mon,Thu *-*-* 09:00:00";
      RandomizedDelaySec = "1h";
      Persistent = true;
      Unit = "github-activity-mirror.service";
    };
    unitConfig = {
      User = config.username;
    };
  };


  systemd.services.github-activity-mirror = {
    description = "Mirror off-platform Git activity from various platforms to Github";
    after = [ "network.target" ];
    unitConfig.ConditionPathExists = settingsPath;
    path = with pkgs; [ git openssh ];
    serviceConfig = {
      ExecStart = "${githubActivityMirror}/bin/github-activity-mirror ${settingsPath}";
      Type = "simple";  # Takes many minutes to finish, use "simple" instead
      Restart = "no";
      User = config.username;
    };
  };
}
