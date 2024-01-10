{ pkgs, ... }:

{
  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    #music = "${config.home.homeDirectory}/Media/Music";
    #videos = "${config.home.homeDirectory}/Media/Videos";
    #pictures = "${config.home.homeDirectory}/Media/Pictures";
    #templates = "${config.home.homeDirectory}/Templates";
    #download = "${config.home.homeDirectory}/Downloads";
    #documents = "${config.home.homeDirectory}/Documents";
    #desktop = null;
    #publicShare = null;
    #extraConfig = {
    #  XDG_DOTFILES_DIR = "${config.home.homeDirectory}/.dotfiles";
    #  XDG_ARCHIVE_DIR = "${config.home.homeDirectory}/Archive";
    #  XDG_VM_DIR = "${config.home.homeDirectory}/Machines";
    #  XDG_ORG_DIR = "${config.home.homeDirectory}/Org";
    #  XDG_PODCAST_DIR = "${config.home.homeDirectory}/Media/Podcasts";
    #  XDG_BOOK_DIR = "${config.home.homeDirectory}/Media/Books";
    #};
  };
  #xdg.portal.enable = true;
}
