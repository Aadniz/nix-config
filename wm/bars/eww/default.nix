{config, pkgs, lib, ...}:

{
  home.packages = with pkgs; [
    eww-wayland
  ];

  home.file.".config/eww/eww.yuck".source = ./eww.yuck;
  home.file.".config/eww/eww.scss".source = ./eww.scss;
  home.file.".config/eww/scripts/getvol".source = ./scripts/getvol;
}
