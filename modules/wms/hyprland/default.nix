{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.services.hyprland.enable {
    # Hyprland specific configuration goes here
    #services.xserver.windowManager.hyprland.enable = true;
    # Add other Hyprland configurations as needed
    environment.systemPackages = with pkgs; [
      sssnake
    ];
  };
}
