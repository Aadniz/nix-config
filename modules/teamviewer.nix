{ config, lib, pkgs, ... }:

{
  services = {
    # Needed occasionally to help the parental units with PC problems
    teamviewer.enable = true;
  };
}
