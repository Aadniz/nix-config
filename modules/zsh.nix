{ config, lib, pkgs, ... }:
let
  hexToInt = hex: (builtins.fromTOML "a = 0x${hex}").a;
  isBright = color: let
    r = hexToInt (builtins.substring 1 2 color);
    g = hexToInt (builtins.substring 3 2 color);
    b = hexToInt (builtins.substring 5 2 color);
    brightness = (r * 299 + g * 587 + b * 114) / 1000;
  in
    brightness > 186;
in
{
  environment.systemPackages = with pkgs; [
    zsh
    zoxide
  ];

  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  hm.programs.zsh = {
    enable = true;
    # My teacher said oh-my-zsh is bloated
    oh-my-zsh.enable = true;
    #shellAliases = myAliases;
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
          owner = "Aadniz";
          repo = "bullet-train.zsh";
          rev = "d566ed5e1a48507ef1c04da2b194bda14e07dbe7";
          sha256 = "sha256-hK43dI47yLXKGs2TuKoTrchkoHg1+pUtwR8LtQQplk4=";
        };
      }
    ];

    initExtraFirst = /* bash */ ''

      function is_bright {
        local color=$1
        local r=$(echo $color | cut -c2-3)
        local g=$(echo $color | cut -c4-5)
        local b=$(echo $color | cut -c6-7)
        local brightness=$(( (0x$r * 299 + 0x$g * 587 + 0x$b * 114) / 1000 ))
        [ $brightness -gt 186 ]
      }

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
      export BULLETTRAIN_CUSTOM_BG=${config.theme.primary}
      export BULLETTRAIN_CUSTOM_FG=${if isBright config.theme.primary then config.theme.background else config.theme.foreground}
      export BULLETTRAIN_CUSTOM_MSG=${config.nickname}

      export BULLETTRAIN_DIR_BG=${config.theme.color8}
      export BULLETTRAIN_DIR_FG=${if isBright config.theme.color8 then config.theme.background else config.theme.foreground}
      export BULLETTRAIN_STATUS_ERROR_BG=${config.theme.color1}
      export BULLETTRAIN_STATUS_BG=${config.theme.color8}
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
