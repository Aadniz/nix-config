{ config, lib, pkgs, ... }:

{

  home.packages = with pkgs; [
    protonmail-bridge
    #gnome.gnome-keyring
    pass
  ];

  systemd.user.services.gnome3.gnome-keyring.enable = true;

  systemd.user.services = {
    protonmail-bridge = {
      Unit = {
        Description = "Protonmail Bridge";
        After = [ "network.target" ];
      };
      Service = {
        ExecStartPre = "${pkgs.coreutils}/bin/sleep 5";
        ExecStart = "${pkgs.protonmail-bridge}/bin/protonmail-bridge --no-window --noninteractive";
        Restart = "always";
        RestartSec = 30;
        path = [ pkgs.pass ];
      };
      Install.WantedBy = [ "default.target" ];
    };
  };
}
