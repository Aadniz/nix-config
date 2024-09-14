{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    R
    btop
    file
    git
    gotop
    jq
    neofetch
    nil
    pfetch
    termdown
  ];
}
