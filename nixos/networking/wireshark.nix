{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wireshark-qt
    qt6.full
  ];

  programs.wireshark.enable = true;
}
