{ config, lib, pkgs, ... }:

{
  imports = [
    ./wireshark.nix
    ./wireguard.nix
  ];

  networking.hostName = "nix"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Enable networking
  networking.networkmanager.enable = true;
}
