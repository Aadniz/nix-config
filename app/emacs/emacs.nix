{ pkgs, config, lib, ... }:
let
  splash-image = ./assets/110717214_p0_edited.png;
in
{

  xdg = {
    enable = true;
    configFile = {
      "doom-config/config.el".source = ./config.el;
      "doom-config/init.el".source = ./init.el;
      "doom-config/packages.el".source = ./packages.el;
      "doom-config/custom.el".source = ./custom.el;
      "doom-config/splash.png".source = splash-image;
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
  ];
}
