{ config, pkgs, username, ... }:

{
  imports = [
    ./sway.nix
    ./hyprland.nix
  ];

  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "sway";
        user = "${username}";
      };
      default_session = initial_session;
    };
  };
}
