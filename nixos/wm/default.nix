{ config, pkgs, username, wm, inputs, ... }:
let
  command = if (wm == "sway") then "${pkgs.sway}/bin/sway" else "${inputs.hyprland.packages.${pkgs.system}.hyprland}/bin/Hyprland";
in
{
  imports =
    let
      wmConfig = if wm == "sway" then
        [ ./sway.nix ]
      else if wm == "hyprland" then
        [ ./hyprland.nix ]
      else
        [ ];
    in
      wmConfig ++ [
        ./pinnacle.nix
      ];

  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        inherit command;
        user = "${username}";
      };
      default_session = initial_session;
    };
  };
}
