{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ../../common
    ../../options
  ] ++ [  # Extended settings config
    ./tor.nix
  ] ++ [  # Include the modules you want to have on this host
    ../../modules/audio.nix
    ../../modules/fcitx5
    ../../modules/home-manager.nix
    ../../modules/home.nix
    ../../modules/netdata.nix
    ../../modules/networking.nix
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
    ../../modules/apps/discord.nix
    ../../modules/apps/emacs
    ../../modules/apps/feh
    ../../modules/apps/firefox.nix
    ../../modules/apps/jetbrains
    ../../modules/apps/kitty
    ../../modules/apps/spotify.nix
  ] ++ [  # Include all programming languages needed
    ../../modules/langs/html.nix
    ../../modules/langs/php.nix
  ];

  # Don't need any additional config for the apps, just throw them in here
  environment.systemPackages = with pkgs; [
    element-desktop anki gparted krita signal-desktop-bin zoom-us userhosts
  ];

  username = "chiya";
  nickname = "chiya@onemix";
  hostname = "onemix";
  flakeDir = "/home/${config.username}/.dots";
  wms = ["sway"];
  theme.wallpaper = ../../wallpapers/kitan_7983.jpg;
  theme.primary = "#EDC26E";
  theme.secondary = "#CC7573";
  theme.background = "#041520";
}
