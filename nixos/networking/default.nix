{ config, lib, pkgs, ... }:

{
  imports = [
#    ./wireguard.nix  # Main PC doesn't need this anymore
    ./wireshark.nix
  ];

  environment.systemPackages = with pkgs; [
    tcpdump
  ];

  networking.hostName = "nix"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Enable networking
  networking.networkmanager.enable = false;

  # Disable firewall
  networking.firewall.enable = false;

  # Setup use of br0 instead of raw interface
  networking.useDHCP = false;
  networking.interfaces."enp38s0" = {
    useDHCP = false;
    ipv4.addresses = [{
      address = "192.168.1.111";
      prefixLength = 24;
    }];
  };
  networking.interfaces."enp39s0" = {
    useDHCP = false;
  };
  networking.defaultGateway = "192.168.1.1";
  networking.nameservers = [ "9.9.9.9" "95.215.19.53" ];
}
