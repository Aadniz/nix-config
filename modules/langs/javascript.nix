{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nodejs
    typescript
    bun
  ] ++ (with nodePackages; [
    webpack
    npm
  ]);
}
