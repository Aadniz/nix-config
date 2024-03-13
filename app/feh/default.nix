{ config, lib, pkgs, theme, ... }:

{

  xdg = {
    enable = true;
    configFile = {
      "feh/themes".text = ''
        feh \
        --image-bg "${theme.background}" \
        -S mtime \
        -g 1000x1000 \
        --scale-down \
        --auto-reload
      '';
      "feh/buttons".source = ./buttons;
      "feh/keys".source = ./keys;
    };
  };

  home.packages = with pkgs; [
    feh
  ];
}
