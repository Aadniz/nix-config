{ config, lib, pkgs, ... }:

{
  imports = [
    ./boot.nix
    ./firefox.nix
    ./fonts.nix
    ./networking.nix
    ./nautilus.nix
  ];

  security.sudo.extraConfig = ''
    Defaults lecture = never
    Defaults passprompt = "[sudo] Enter the magic words: "
    Defaults pwfeedback
    Defaults passwd_timeout=0
  '';

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    acpi
    btop
    dig
    file
    gdb
    git
    gotop
    inetutils
    jq
    libreoffice
    mpv
    direnv
    neofetch
    nil
    obs-studio
    pfetch
    python3
    termdown
    unison
    wget
  ];
}
