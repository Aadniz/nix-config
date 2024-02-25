{ config, pkgs, wm, ... }:

{
  imports =
    let
      wmConfig = if wm == "sway" then
        [ ./sway ]
      else if wm == "hyprland" then
        [ ./hyprland ]
      else
        [ ];
    in
      wmConfig ++ [
        #./pinnacle.nix
      ];

  home.packages = with pkgs; [
    remmina
    grim
    slurp
  ];
}
