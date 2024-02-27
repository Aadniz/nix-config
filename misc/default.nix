{ config, pkgs, ... }:

{
  imports = [
    ./scripts
    ./fcitx5.nix
    ./gtk.nix
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
