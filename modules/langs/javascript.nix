{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nodejs
    typescript
    bun
    terser
  ] ++ (with nodePackages; [
    webpack
    npm
  ]);
}
