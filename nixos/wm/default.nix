{ config, pkgs, username, wm, ... }:
let
  command = if (wm == "sway") then "${pkgs.sway}/bin/sway" else "${pkgs.hyprland}/bin/Hyprland";
in
{
  imports = [
    ./sway.nix
    ./hyprland.nix
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
