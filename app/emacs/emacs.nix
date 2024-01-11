{ pkgs, config, lib, ... }:
let
    my-emacs = let
    emacsPkg = with pkgs;
      (emacsPackagesFor emacs29).emacsWithPackages
      (ps: with ps; [ vterm tsc treesit-grammars.with-all-grammars ]);
    pathDeps = with pkgs; [
      git
      dockfmt
      libxml2.bin
      rstfmt
      texlive.combined.scheme-medium
      python3
      binutils
      (ripgrep.override { withPCRE2 = true; })
      fd
      gnutls
      imagemagick
      zstd
      shfmt
      maim
      shellcheck
      sqlite
      editorconfig-core-c
      nodePackages.mermaid-cli
      pandoc
      gcc
      gdb
      lldb
      graphviz-nox
      wordnet
      beancount
      beancount-language-server
      fava
      html-tidy
      nodejs
      nodePackages.bash-language-server
      nodePackages.stylelint
      nodePackages.dockerfile-language-server-nodejs
      nodePackages.js-beautify
      nodePackages.typescript-language-server
      nodePackages.typescript
      (writeScriptBin "vscode-css-language-server" ''
        #!${nodejs}/bin/node
        require('${vscodium}/lib/vscode/resources/app/extensions/css-language-features/server/dist/node/cssServerMain.js')
      '')
      (writeScriptBin "vscode-html-language-server" ''
        #!${nodejs}/bin/node
        require('${vscodium}/lib/vscode/resources/app/extensions/html-language-features/server/dist/node/htmlServerMain.js')
      '')
      (writeScriptBin "vscode-json-language-server" ''
        #!${nodejs}/bin/node
        require('${vscodium}/lib/vscode/resources/app/extensions/json-language-features/server/dist/node/jsonServerMain.js')
      '')
      (writeScriptBin "vscode-markdown-language-server" ''
        #!${nodejs}/bin/node
        require('${vscodium}/lib/vscode/resources/app/extensions/markdown-language-features/server/dist/node/workerMain.js')
      '')
      nodePackages.yaml-language-server
      nodePackages.unified-language-server
      nodePackages.prettier
      jq
      nixfmt
      nil
      rnix-lsp
      black
      isort
      pipenv
      python3Packages.pytest
      python3Packages.nose
      python3Packages.pyflakes
      python3Packages.python-lsp-server
      python3Packages.grip
      multimarkdown
      xclip
      xdotool
      xorg.xwininfo
      xorg.xprop
      watchman
    ];
  in emacsPkg // (pkgs.symlinkJoin {
    name = "my-emacs";
    paths = [ emacsPkg ];
    nativeBuildInputs = [ pkgs.makeBinaryWrapper ];
    postBuild = ''
      wrapProgram $out/bin/emacs \
        --prefix PATH : ${lib.makeBinPath pathDeps} \
        --set LSP_USE_PLISTS true
      wrapProgram $out/bin/emacsclient \
        --prefix PATH : ${lib.makeBinPath pathDeps} \
        --set LSP_USE_PLISTS true
    '';
  });
in
{
  home = {
    sessionPath = [ "${config.xdg.configHome}/emacs/bin" ];
    sessionVariables = {
      DOOMDIR = "${config.xdg.configHome}/doom-config";
      DOOMLOCALDIR = "${config.xdg.dataHome}/doom";
    };
  };

 #programs.my-emacs = {
 #  enable = true;
 #   package = my-emacs;
 #   client.enable = true;
 #};

  xdg = {
    enable = true;
    configFile = {
      "doom-config/config.el" = {
        source = ./config.el;
      };
      "doom-config/init.el" = {
        source = ./init.el;
        onChange = "${pkgs.writeShellScript "doom-config-init-change" ''
          export PATH="${my-emacs}/bin:$PATH"
          export DOOMDIR="${config.home.sessionVariables.DOOMDIR}"
          export DOOMLOCALDIR="${config.home.sessionVariables.DOOMLOCALDIR}"
          ${config.xdg.configHome}/doom-emacs/bin/doom --force sync
          echo MY-EMACS ${my-emacs}
          echo DOOMDIR $DOOMDIR
          echo DOOMLOCALDIR $DOOMLOCALDIR
        ''}";
      };
      "doom-config/packages.el" = {
        source = ./packages.el;
        onChange = "${pkgs.writeShellScript "doom-config-packages-change" ''
          export PATH="${my-emacs}/bin:$PATH"
          export DOOMDIR="${config.home.sessionVariables.DOOMDIR}"
          export DOOMLOCALDIR="${config.home.sessionVariables.DOOMLOCALDIR}"
          ${config.xdg.configHome}/doom-emacs/bin/doom --force sync -u
          echo MY-EMACS ${my-emacs}
          echo DOOMDIR $DOOMDIR
          echo DOOMLOCALDIR $DOOMLOCALDIR
        ''}";
      };
      "doom-config/custom.el".source = ./custom.el;
      "doom-emacs" = {
        source = pkgs.fetchFromGitHub {
          owner = "doomemacs";
          repo = "doomemacs";
          rev = "03d692f129633e3bf0bd100d91b3ebf3f77db6d1";
          sha256 = "0p6f481237ddiib8lxvl5qndyfhz9ribxwzz6ns0n6lkzzlh7m1x";
        };
        onChange = "${pkgs.writeShellScript "doom-change" ''
          export PATH="${my-emacs}/bin:$PATH"
          export DOOMDIR="${config.home.sessionVariables.DOOMDIR}"
          export DOOMLOCALDIR="${config.home.sessionVariables.DOOMLOCALDIR}"
          if [ ! -d "$DOOMLOCALDIR" ]; then
            ${config.xdg.configHome}/doom-emacs/bin/doom --force install
          else
            ${config.xdg.configHome}/doom-emacs/bin/doom --force clean
            ${config.xdg.configHome}/doom-emacs/bin/doom --force sync -u
          fi
          echo MY-EMACS ${my-emacs}
          echo DOOMDIR $DOOMDIR
          echo DOOMLOCALDIR $DOOMLOCALDIR
        ''}";
      };
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
    my-emacs
    #emacs
  ];
}
