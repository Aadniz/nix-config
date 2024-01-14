{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    netdata
  ];

  services.netdata = {
    enable = true;
    config = {
      global = {
        "memory mode" = "dbengine";
        "history" = 24*60*60*30; # 1 month
      };
    };
  };
}
