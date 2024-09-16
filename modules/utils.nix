{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    R
    btop
    file
    gdb
    git
    gotop
    jq
    neofetch
    nil
    pfetch
    termdown
  ];
}
