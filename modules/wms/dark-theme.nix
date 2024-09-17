{ config, lib, pkgs, ... }:

{
  hm.home.pointerCursor = {
    size = 24;
    name = "volantes_cursors";
    package = pkgs.volantes-cursors;
    x11 = {
      enable = true;
      defaultCursor = "volantes_cursors";
    };
  };

  hm.gtk = {
    enable = true;
    cursorTheme = {
      size = 24;
      name = "volantes_cursors";
      package = pkgs.volantes-cursors;
    };

    iconTheme = {
      package = (pkgs.colloid-icon-theme.override { schemeVariants = [ "nord" ]; });
      name = "Colloid-nord-dark";
    };

    theme = {
      package = (pkgs.colloid-gtk-theme.override { tweaks = [ "nord" ]; colorVariants = [ "dark" ]; });
      name = "Colloid-Dark-Nord";
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  hm.dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}
