{ config, lib, pkgs, ... }:

{

  home.packages = with pkgs; [
    yt-dlp
  ];

  programs.zsh = {
    enable = true;
    shellAliases = {
      ".." =   "cd ..";
      ll =     "ls -aslhpx --group-directories-first";
      ytmp3 =  "yt-dlp -x --audio-format mp3 --no-mtime --add-metadata --xattrs --embed-thumbnail -o '%(title)s.%(ext)s' ";
      yt =     "yt-dlp --add-metadata ";
      update = "sudo nixos-rebuild switch";
    };
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
  };

}
