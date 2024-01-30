{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    dconf
    tokyo-night-gtk
  ];

  gtk = {
    enable = true;
    iconTheme = {
      name = "Tokyonight-Dark";
    };
    theme = {
      name = "Tokyonight-Storm-BL";
    };
    #cursorTheme = {
    #  name = "Catpuccin-Mocha-Maroon-Cursors";
    #  package = pkgs.catppuccin-cursors.mochaMaroon;
    #};
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "Tokyonight-Storm-BL";
      icon-theme = "Tokyonight-Dark";
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "Tokyonight-Storm-BL";
    };
  };

  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.mochaDark;
    name = "Catppuccin-Mocha-Maroon-Cursors";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
}
