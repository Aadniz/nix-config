{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    dconf
    tokyo-night-gtk
    (
      pkgs.catppuccin-gtk.override {
        accents = ["pink"];
        tweaks = ["rimless"];
        size = "compact";
        variant = "mocha";
      }
    )
  ];

  gtk = {
    enable = true;

    theme = {
      name = "Catppuccin-Mocha-Compact-Pink-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = ["pink"];
        tweaks = ["rimless"];
        size = "compact";
        variant = "mocha";
      };
    };

    iconTheme = {
      package = pkgs.catppuccin-papirus-folders;
      name = "Papirus-Dark";
    };

    cursorTheme = {
      name = "Numix-Cursor";
      package = pkgs.numix-cursor-theme;
    };

    gtk3.extraConfig = {
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk2.extraConfig = ''
      gtk-xft-antialias=1
      gtk-xft-hinting=1
      gtk-xft-hintstyle="hintslight"
      gtk-xft-rgba="rgb"
    '';
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "Catppuccin-Mocha-Compact-Pink-Dark";
      icon-theme = "Papirus-Dark";
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "Catppuccin-Mocha-Compact-Pink-Dark";
    };

    "org/gnome/nautilus/preferences" = {
      default-sort-in-reverse-order = true;
      default-sort-order = "mtime";
    };
  };

  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.frappeDark;
    name = "Catppuccin-Frappe-Dark-Cursors";
    size = 24;
    gtk.enable = true;
  };
}
