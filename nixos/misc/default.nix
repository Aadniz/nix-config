{ config, lib, pkgs, ... }:

{
  imports = [
    ./audio.nix
    ./netdata.nix
    ./dunst.nix
    ./fonts.nix
    ./ime.nix
    ./v4l2loopback.nix
  ];

  environment.systemPackages = with pkgs; [
    python3
    inetutils  # Telnet
    pciutils
    killall
  ];

  services = {
    # Needed occasionally to help the parental units with PC problems
    #teamviewer.enable = true;
  };
}
