{ config, pkgs, ... }:

{
  imports = [
    ./fcitx5.nix
    ./gtk.nix
    ./kde.nix
    ./scripts
  ];


  home.packages = with pkgs; [
    bc
    direnv
    ffmpeg
    file
    htop
    ibus
    jq
    mpd
    prettyping
    python3
    termdown
  ];
}
