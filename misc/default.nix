{ config, pkgs, ... }:

{
  imports = [
    ./scripts
    ./fcitx5.nix
    ./gtk.nix
    ./kde.nix
  ];


  home.packages = with pkgs; [
    ffmpeg
    file
    bc
    jq
    mpd
    ibus
    htop
    termdown
    python3
    poetry
    direnv
    prettyping
  ];
}
