{ config, lib, pkgs, ... }:

{
  networking.nameservers = [ "95.215.19.53" "9.9.9.9" ];

  # Prevent "warning: the following units failed: NetworkManager-wait-online.service"
  systemd.services.NetworkManager-wait-online.enable = false;
}
