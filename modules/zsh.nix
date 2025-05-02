{ config, lib, pkgs, ... }:
let
  hexToInt = hex: (builtins.fromTOML "a = 0x${hex}").a;

  # Calculate brightness of a hex color (0-255)
  brightness = color: let
    r = hexToInt (builtins.substring 1 2 color);
    g = hexToInt (builtins.substring 3 2 color);
    b = hexToInt (builtins.substring 5 2 color);
  in (r * 299 + g * 587 + b * 114) / 1000;

  # Return the brightest of two colors
  brightest = color1: color2:
    if (brightness color1) > (brightness color2)
    then color1 else color2;

  # Return the darkest of two colors
  darkest = color1: color2:
    if (brightness color1) < (brightness color2)
    then color1 else color2;
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
          rev = "c3a422f43cb995f168a3fcfa72beaf53b7271d6f";
          sha256 = "sha256-VLJQryaIwU9Hsnr3wAgw1je+WmigFsIBS795TfCNJEk=";
        };
      }
    ];

    zplug = {
      enable = true;
      plugins = [
        { name = "joshskidmore/zsh-fzf-history-search"; }
        { name = "spwhitt/nix-zsh-completions"; }
      ];
    };

    initContent = lib.mkBefore /* bash */ ''

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
      export BULLETTRAIN_STATUS_EXIT_SHOW=true
      export BULLETTRAIN_PROMPT_SEPARATE_LINE=false
      export BULLETTRAIN_PROMPT_CHAR=""
      export BULLETTRAIN_PROMPT_ADD_NEWLINE=false
      export BULLETTRAIN_CUSTOM_BG=${brightest config.theme.primary config.theme.background}
      export BULLETTRAIN_CUSTOM_FG=${darkest config.theme.primary config.theme.background}
      export BULLETTRAIN_CUSTOM_MSG=${config.nickname}
      export BULLETTRAIN_DIR_BG=${darkest config.theme.third config.theme.foreground}
      export BULLETTRAIN_DIR_FG=${brightest config.theme.third config.theme.foreground}
      export BULLETTRAIN_STATUS_ERROR_BG=${config.theme.color1}
      export BULLETTRAIN_STATUS_BG=${config.theme.color8}
      export BULLETTRAIN_EXEC_TIME_BG=${config.theme.color0}
      export BULLETTRAIN_EXEC_TIME_FG=${config.theme.foreground}
      export BULLETTRAIN_GIT_BG=${config.theme.color8}
      export BULLETTRAIN_GIT_FG=${config.theme.foreground}

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
