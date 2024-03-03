{ config, lib, pkgs, ... }:

{
  imports = [
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    fzf
    zoxide
  ];
}
