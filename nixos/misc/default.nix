{ config, lib, pkgs, ... }:

{
  imports = [
    ./audio.nix
    ./netdata.nix
    ./dunst.nix
  ];

  environment.systemPackages = with pkgs; [
    python3
    inetutils
    fira-code
    font-awesome
    iosevka
    source-sans-pro
    source-serif-pro
    #(nerdfonts.override { fonts = [ "DroidSansMono" ]; })
    font-awesome_5
    (nerdfonts.override { fonts = [ "CascadiaCode" "JetBrainsMono" "FiraCode" ]; })
    ipafont
    kochi-substitute
  ];
}
