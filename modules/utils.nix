{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    jq
    termdown
    r
  ];
}
