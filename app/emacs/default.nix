{ pkgs, config, lib, name, hostname, username, email, wm, wallpaper, theme, dotfilesDir, ... }:
let
  splash-image = ./assets/102591953_p0_edited2_icon.png;
in
{

  xdg = {
    enable = true;
    configFile = {
      "doom/config.el".source = ./config.el;
      "doom/init.el".source = ./init.el;
      "doom/packages.el".source = ./packages.el;
      "doom/custom.el".source = ./custom.el;
      "doom/faces.el".source = ./faces.el;
      "doom/splash.png".source = splash-image;
    };
  };

  home.packages = with pkgs; [
    # DOOM Emacs dependencies
    binutils
    (ripgrep.override { withPCRE2 = true; })
    gnutls
    fd
    imagemagick
    zstd
    nodePackages.javascript-typescript-langserver
    sqlite
    editorconfig-core-c
    emacs-all-the-icons-fonts
    emacs
    git
    ispell
    pandoc
    lldb # C++, Rust, C debugger
  ];

  xdg.configFile."doom/system-vars.el".text = /* lisp */ ''
  ;;; ~/.config/doom/config.el -*- lexical-binding: t; -*-

  ;; Import relevant variables from flake into emacs

  (setq user-wallpaper "''+wallpaper+''") ; wallpaper
  (setq user-username "''+username+''") ; username
  (setq user-mail-address "''+email+''") ; email
  (setq user-home-directory "/home/''+username+''") ; absolute path to home directory as string
  (setq user-full-name "''+name+''") ; name
  (setq system-wm-type "''+wm+''") ; Sway or something else?
  (setq system-hostname "''+hostname+''") ; hostname
  (setq dotfiles-dir "''+dotfilesDir+''") ; import location of dotfiles directory

  ;; Convert theme structure into a list of cons cells
  (setq user-theme (list (cons 'foreground "''+theme.foreground+''")
                         (cons 'background "''+theme.background+''")
                         (cons 'primary "''+theme.primary+''")
                         (cons 'secondary "''+theme.secondary+''")
                         (cons 'third "''+theme.third+''")
                         (cons 'color0 "''+theme.color0+''")
                         (cons 'color1 "''+theme.color1+''")
                         (cons 'color2 "''+theme.color2+''")
                         (cons 'color3 "''+theme.color3+''")
                         (cons 'color4 "''+theme.color4+''")
                         (cons 'color5 "''+theme.color5+''")
                         (cons 'color6 "''+theme.color6+''")
                         (cons 'color7 "''+theme.color7+''")
                         (cons 'color8 "''+theme.color8+''")
                         (cons 'color9 "''+theme.color9+''")
                         (cons 'color10 "''+theme.color10+''")
                         (cons 'color11 "''+theme.color11+''")
                         (cons 'color12 "''+theme.color12+''")
                         (cons 'color13 "''+theme.color13+''")
                         (cons 'color14 "''+theme.color14+''")
                         (cons 'color15 "''+theme.color15+''")))
  '';
}
