{config, pkgs, lib, inputs, ...}:

# Pretty much yeeted from https://github.com/infinisil/system/blob/07534666e0592d9ceb1fc157dc48baa7b1494d99/config/new-modules/vim.nix
{
  home.packages = with pkgs; [
    nodePackages.bash-language-server
    wl-clipboard
    nil
  ];

  programs.neovim = {
    #package = pkgs.neovim-nightly;
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = false;
    withRuby = true;
    withPython3 = true;
    defaultEditor = true;
    
    coc = {
      enable = true;
      settings = {
        languageserver = {
          haskell = {
            command = "haskell-language-server";
            args = ["--lsp"];
            rootPatterns = ["*.cabal" "stack.yaml" "cabal.project" "package.yaml" "hie.yaml"];
            filetypes = ["haskell" "lhaskell"];
            initializationOptions = {
              haskell = {};
            };
          };
          bash = {
            command = "bash-language-server";
            args = ["start"];
            filetypes = ["sh"];
            ignoredRootPaths = ["~"];
          };
          clangd = {
            command = "clangd";
            rootPatterns = ["compile_flags.txt" "compile_commands.json"];
            filetypes = ["c" "cc" "cpp" "c++" "objc" "objcpp"];
          };
          golang = {
            command = "gopls";
            rootPatterns = ["go.mod" ".vim/" ".git/" ".hg/"];
            filetypes = ["go"];
            initializationOptions = {};
          };
          nix = {
            command = "nil";
            filetypes = ["nix"];
            rootPatterns = ["flake.nix"];
            settings.nil.formatting = {
              command = [
                (lib.getExe pkgs.nixfmt)
              ];
            };
          };
        };
        "codeLens.enable" = true;
        #"coc.preferences.formatOnSaveFiletypes" = [ "haskell" "lhaskell" ];
        "coc.preferences.currentFunctionSymbolAutoUpdate" = true;
        "suggest.noselect" = true;
      };
    };

    extraPackages = with pkgs; [
      # for compiling Treesitter parsers
      gcc

      # debuggers
      lldb # comes with lldb-vscode

      # formatters and linters
      nixfmt
      shfmt
      cbfmt
      stylua
      codespell
      statix
      luajitPackages.luacheck
      prettierd

      # LSP servers
      efm-langserver
      nil
      taplo
      gopls
      lua
      shellcheck
      marksman
      sumneko-lua-language-server
      nodePackages_latest.typescript-language-server
      yaml-language-server

      # this includes css-lsp, html-lsp, json-lsp, eslint-lsp
      nodePackages_latest.vscode-langservers-extracted

      # other utils and plugin dependencies
      src-cli
      ripgrep
      fd
      catimg
      sqlite
      lemmy-help
      luajitPackages.jsregexp
      fzf
      cargo
      cargo-nextest
      clippy
      glow
    ]; 

     plugins = with pkgs.vimPlugins; [
       vim-nix
       vim-addon-nix
       undotree
       nvim-treesitter.withAllGrammars
       editorconfig-vim
       coc-json
       coc-explorer
       haskell-vim
       gruvbox-community
       vim-gitgutter


       # For dev of plugins
       (pkgs.vimUtils.buildVimPlugin {
         pname = "vim-rest-console";
         version = "11111111111111111111111111111111111111111";
         src = inputs.vim-rest-console;
       })

       vim-pathogen
     ];

     extraLuaConfig = /* lua */ ''
       require'nvim-treesitter.configs'.setup {
         highlight = {
           enable = true,
         },
       }
     '';

     extraConfig = ''
       set clipboard=unnamedplus
     '';
  };
}
