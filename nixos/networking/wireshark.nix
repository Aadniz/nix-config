{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wireshark-qt
    qt6.full
    termshark
  ];

  programs.wireshark.enable = true;
}
