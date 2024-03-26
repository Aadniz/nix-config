{ config, pkgs, ... }:

{
  imports = [
    #./rust.nix
    ./c.nix
  ];

  home.packages = with pkgs; [
    nodejs
    bun
    gnumake
    python310Packages.python-lsp-server
  ];
}
