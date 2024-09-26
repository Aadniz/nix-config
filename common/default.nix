{ config, lib, pkgs, ... }:

{
  imports = [
    ./boot.nix
    ./fonts.nix
  ];

  security.sudo.extraConfig = ''
    Defaults lecture = never
    Defaults passprompt = "[sudo] Enter the magic words: "
    Defaults pwfeedback
    Defaults passwd_timeout=0
  '';

  environment.systemPackages = with pkgs; [
    btop
    file
    gdb
    git
    gotop
    inetutils
    jq
    libreoffice
    neofetch
    nil
    pfetch
    python3
    termdown
    unison
  ];
}
