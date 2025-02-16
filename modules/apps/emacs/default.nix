{ pkgs, config, lib, ... }:
let
  splash-image = ./assets/TransparentGNU2.png;
in
{

  hm.xdg = {
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

  environment.systemPackages = with pkgs; [
    # DOOM Emacs dependencies
    (ripgrep.override { withPCRE2 = true; })
    binutils
    editorconfig-core-c
    emacs
    emacs-all-the-icons-fonts
    emacsPackages.apheleia
    emacsPackages.prettier
    fd
    git
    gnutls
    imagemagick
    ispell
    lldb # C++, Rust, C debugger
    nixd
    nodePackages.typescript-language-server
    pandoc
    python311Packages.python-lsp-server
    sqlite
    zstd
  ];

  hm.xdg.configFile."doom/system-vars.el".text = /* lisp */ ''
  ;;; ~/.config/doom/config.el -*- lexical-binding: t; -*-

  ;; Import relevant variables from flake into emacs

  (setq user-username "''+config.username+''") ; username
  (setq user-home-directory "/home/''+config.username+''") ; absolute path to home directory as string
  (setq user-full-name "''+config.nickname+''") ; name
  (setq system-hostname "''+config.hostname+''") ; hostname
  (setq dotfiles-dir "''+config.flakeDir+''") ; import location of dotfiles directory

  ;; Convert theme structure into a list of cons cells
  (setq user-theme (list (cons 'foreground "''+config.theme.foreground+''")
                         (cons 'background "''+config.theme.background+''")
                         (cons 'primary "''+config.theme.primary+''")
                         (cons 'secondary "''+config.theme.secondary+''")
                         (cons 'third "''+config.theme.third+''")
                         (cons 'color0 "''+config.theme.color0+''")
                         (cons 'color1 "''+config.theme.color1+''")
                         (cons 'color2 "''+config.theme.color2+''")
                         (cons 'color3 "''+config.theme.color3+''")
                         (cons 'color4 "''+config.theme.color4+''")
                         (cons 'color5 "''+config.theme.color5+''")
                         (cons 'color6 "''+config.theme.color6+''")
                         (cons 'color7 "''+config.theme.color7+''")
                         (cons 'color8 "''+config.theme.color8+''")
                         (cons 'color9 "''+config.theme.color9+''")
                         (cons 'color10 "''+config.theme.color10+''")
                         (cons 'color11 "''+config.theme.color11+''")
                         (cons 'color12 "''+config.theme.color12+''")
                         (cons 'color13 "''+config.theme.color13+''")
                         (cons 'color14 "''+config.theme.color14+''")
                         (cons 'color15 "''+config.theme.color15+''")))
  '';
}
