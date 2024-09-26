{ config, lib, pkgs, ... }:

{

  hm.xdg = {
    enable = true;
    configFile = {
      "feh/themes".text = ''
        feh \
        --image-bg "${config.theme.background}" \
        -S mtime \
        -g 1000x1000 \
        --scale-down \
        --auto-reload
      '';
      "feh/buttons".source = ./buttons;
      "feh/keys".source = ./keys;
    };
  };

  environment.systemPackages = with pkgs; [
    feh
  ];
}
