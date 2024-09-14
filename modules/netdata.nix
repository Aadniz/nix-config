{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    netdata
  ];

  networking.firewall.allowedTCPPorts = [ 19999 ];
  networking.firewall.allowedUDPPorts = [ 19999 ];

  services.netdata = {
    enable = true;
    config = {
      global = {
        "memory mode" = "dbengine";
        "history" = 24*60*60*30*2; # 2 months
      };
    };
  };
}
