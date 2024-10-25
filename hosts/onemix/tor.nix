{ config, lib, pkgs, ... }:

{
  # Enable Tor service with SOCKS port
  # Mostly used for SSH to non-port forwarded hosts
  services.tor = {
    enable = true;
    client = {
      enable = true;
      socksListenAddress = 9050;
    };
  };
}
