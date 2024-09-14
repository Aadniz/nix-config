{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    jq
    termdown
    R
    gotop
    btop
    neofetch
    pfetch
    git
  ];
}
