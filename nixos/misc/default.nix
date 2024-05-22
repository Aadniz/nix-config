{ config, lib, pkgs, ... }:

{
  imports = [
    ./audio.nix
    ./dunst.nix
    ./fonts.nix
    ./ime.nix
    ./netdata.nix
    ./nh.nix
    ./v4l2loopback.nix
  ];

  environment.systemPackages = with pkgs; [
    python3
    inetutils  # Telnet
    pciutils
    killall
    ncdu
  ];

  programs.gnupg.agent.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;

  services = {
    # Needed occasionally to help the parental units with PC problems
    teamviewer.enable = true;
  };
}
