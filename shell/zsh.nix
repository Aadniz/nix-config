{ config, lib, pkgs, dotfilesDir, theme, ... }:
let
  myAliases = import ./aliases.nix {inherit dotfilesDir;};
in
{

  home.packages = with pkgs; [
    yt-dlp
  ];

  programs.zsh = {
    enable = true;
    # My teacher said oh-my-zsh is bloated
    oh-my-zsh.enable = true;
    shellAliases = myAliases;
    history = {
      size = 10000;
      save = 10000;
    };
    plugins = [
      {
        # will source zsh-autosuggestions.plugin.zsh
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.0";
          sha256 = "sha256-KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
       };
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.7.0";
          sha256 = "sha256-eRTk0o35QbPB9kOIV0iDwd0j5P/yewFFISVS/iEfP2g=";
        };
      }
      {
        name = "bullet-train";
        file = "bullet-train.zsh-theme";
        src = pkgs.fetchFromGitHub {
          owner = "caiogondim";
          repo = "bullet-train.zsh";
          rev = "d60f62c34b3d9253292eb8be81fb46fa65d8f048";
          sha256 = "sha256-EsoCrKXmAfhSNFvUka+BglBDXM1npef4ddg7SVScxSs=";
        };
      }
    ];

    initExtraFirst = /* bash */ ''
      export BULLETTRAIN_PROMPT_ORDER=(
        status
        custom
        dir
        screen
        perl
        ruby
        virtualenv
        aws
        go
        rust
        elixir
        git
        hg
        cmd_exec_time
      )
      export BULLETTRAIN_PROMPT_SEPARATE_LINE=false
      export BULLETTRAIN_PROMPT_CHAR=""
      export BULLETTRAIN_PROMPT_ADD_NEWLINE=false
      export BULLETTRAIN_CUSTOM_BG=${theme.primary}
      export BULLETTRAIN_CUSTOM_FG=${theme.foreground}
      export BULLETTRAIN_CUSTOM_MSG=千屋
      export BULLETTRAIN_DIR_BG=${theme.color8}
      export BULLETTRAIN_DIR_FG=${theme.foreground}
      export BULLETTRAIN_STATUS_ERROR_BG=${theme.color8}
      export BULLETTRAIN_STATUS_BG=${theme.color8}
    '';

    initExtra = ''
      bindkey  "^[[H"    beginning-of-line
      bindkey  "^[[F"    end-of-line
      bindkey  "^[[3~"   delete-char
      bindkey  "^[[1;5C" forward-word
      bindkey  "^[[1;5D" backward-word
      bindkey  "^[[A"    history-beginning-search-backward
      bindkey  "^[[B"    history-beginning-search-forward

      autoload -U history-search-end #needed for -end
      zle -N history-beginning-search-backward-end history-search-end
      zle -N history-beginning-search-forward-end history-search-end

      #when going up go up only beggining of curr word history
      bindkey '\e[A' history-beginning-search-backward-end
      bindkey '\e[B' history-beginning-search-forward-end
      #ctrl + arrow forward/backward word
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word
      #alt + arrow forward/backward word
      bindkey "^[[1;3C" forward-word
      bindkey "^[[1;3D" backward-word
      #alt + delete delete whole word
      bindkey "\e\x7f" backward-kill-word

      eval "$(${pkgs.zoxide}/bin/zoxide init zsh)"
      alias cd=z
    '';
  };
}
