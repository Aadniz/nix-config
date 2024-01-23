{ config, lib, pkgs, ... }:

{
  imports = [
    ./audio.nix
    ./netdata.nix
    ./dunst.nix
    ./fonts.nix
  ];

  environment.systemPackages = with pkgs; [
    python3
    inetutils  # Telnet
  ];
}
