{ config, lib, pkgs, dotfilesDir, ... }:
let
  myAliases = import ./aliases.nix {inherit dotfilesDir;};
in
{

  home.packages = with pkgs; [
    yt-dlp
  ];

  programs.zsh = {
    enable = true;
    shellAliases = myAliases;
    #histSize = 10000;
    #histFile = "${config.xdg.dataHome}/zsh/history";

    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
        { name = "zsh-users/zsh-syntax-highlighting"; }
        { name = "zsh-users/zsh-completions"; }
        { name = "zsh-users/zsh-history-substring-search"; }
        #{ name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; } # Installations with additional options. For the list of options, please refer to Zplug README.
        { name = "themes/agnoster"; tags = ["from:oh-my-zsh"]; }
      ];
    };

    initExtra = ''
      eval "$(${pkgs.zoxide}/bin/zoxide init zsh)"
      alias cd=z
    '';
  };
}
