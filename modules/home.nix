{ config, lib, pkgs, ... }:

{
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    hm.home.stateVersion = config.system.stateVersion;
}
