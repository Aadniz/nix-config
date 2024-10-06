{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ../../options
  ] ++ [  # Extended settings config
    ./wireguard.nix
  ] ++ [  # Include the modules you want to have on this host
    ../../common
    ../../modules/audio.nix
    ../../modules/home-manager.nix
    ../../modules/home.nix
    ../../modules/netdata.nix
    ../../modules/nh.nix
    ../../modules/nix.nix
    ../../modules/ssh.nix
    ../../modules/status-checker.nix
    ../../modules/teamviewer.nix
    ../../modules/utils.nix
    ../../modules/wms
    ../../modules/zsh.nix
  ] ++ [  # Include all apps you want to use on this host
    ../../modules/apps/bingchat.nix
    ../../modules/apps/detyx.nix
    ../../modules/apps/emacs
    ../../modules/apps/feh
    ../../modules/apps/kitty
    ../../modules/apps/spotify.nix
  ];

  # Don't need any additional config for the apps, just throw them in here
  environment.systemPackages = with pkgs; [
    discord element-desktop anki gparted krita signal-desktop zoom-us
  ];

  username = "chiya";
  nickname = "千夜";
  hostname = "sushi";
  flakeDir = "/home/${config.username}/.dots";
  wms = ["sway"];
  theme.wallpaper = ../../wallpapers/kitan_7983.jpg;
  theme.primary = "#EDC26E";
  theme.secondary = "#CC7573";
  theme.background = "#041520";
}
