{ config, lib, pkgs, ... }:

{
  imports = [
    ./fonts.nix
    ./boot.nix
  ];

  environment.systemPackages = with pkgs; [
    btop
    file
    gdb
    git
    gotop
    inetutils
    jq
    libreoffice
    neofetch
    nil
    pfetch
    python3
    termdown
    unison
  ];
}
