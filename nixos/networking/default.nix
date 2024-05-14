{ config, lib, pkgs, ... }:

{
  imports = [
    ./wireguard.nix
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
  networking.interfaces."enp38s0".useDHCP = false;
  networking.interfaces."enp39s0".useDHCP = false;
  networking.interfaces.br0.useDHCP = false;
  networking.bridges = {
    "br0" = {
      interfaces = [ "enp38s0" "enp39s0" ];
    };
  };
  networking.interfaces.br0.ipv4.addresses = [ {
    address = "192.168.111.111";
    prefixLength = 24;
  } ];
  networking.defaultGateway = "192.168.111.1";
  networking.nameservers = [ "9.9.9.9" "95.215.19.53" ];
}
