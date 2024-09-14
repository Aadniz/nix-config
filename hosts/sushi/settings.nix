{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ../../options
  ] ++ [ # Include the modules you want to have on this host
    ../../modules/utils.nix
    ../../modules/home-manager.nix
    ../../modules/home.nix
    ../../modules/netdata.nix
    ../../modules/nh.nix
    ../../modules/nix.nix
    ../../modules/zsh.nix
  ];

  username = "chiya";
  nickname = "千夜";
  hostname = "sushi";
  flakeDir = "/home/${config.username}/.dots";
  wms = ["sway"];
  theme = ../../wallpapers/kitan_7983.jpg
}
