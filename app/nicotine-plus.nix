{ config, lib, pkgs, ... }:

{

  home.packages = with pkgs; [
    nicotine-plus
    dconf
    tokyo-night-gtk
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Colloid-Grey-Dark";
      package = pkgs.colloid-gtk-theme.override {
        themeVariants = [ "default" "grey" ];
        colorVariants = [ "dark" ];
        sizeVariants = [ "standard" ];
        tweaks = [ "float"];
      };
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "Tokyonight-Dark-B-LB";
    };
  };
}
