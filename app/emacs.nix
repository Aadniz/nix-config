
{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
      emacs
  ];

  # doom-emacs is a configuration framework for GNU Emacs.
  #doomemacs = {
  #  url = "github:doomemacs/doomemacs";
  #  flake = false;
  #};
}
