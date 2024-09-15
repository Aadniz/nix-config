{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.services.i3.enable {
    # i3 specific configuration goes here
    # services.xserver.windowManager.i3.enable = true;
    # Add other i3 configurations as needed

    environment.systemPackages = with pkgs; [
      tree
    ];
  };
}
