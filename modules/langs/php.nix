{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    php
  ] ++ (with php82Packages; [
    composer
  ]);
}
