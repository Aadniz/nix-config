{ config, lib, pkgs, ... }:

{
  hm.systemd.user.services.hydroxide = {
    Unit = {
      Description = "Protonmail (Hydroxide)";
      After = [ "network.target" ];
    };
    Service = {
      ExecStartPre = "${pkgs.coreutils}/bin/sleep 5";
      ExecStart = "${lib.getExe pkgs.hydroxide} -api-endpoint https://mail.protonmailrmez3lotccipshtkleegetolb73fuirgj7r4o4vfu7ozyd.onion/api serve";
      Restart = "always";
      RestartSec = 30;
      Environment = "HTTPS_PROXY=socks5://127.0.0.1:9050";
      StandardOutput = "journal";
      StandardError = "journal";
    };
    Install.WantedBy = [ "default.target" ];
  };
}
