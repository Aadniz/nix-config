{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    sysstat
    bc
    playerctl
    cmus
    rhythmbox
  ];

  imports = [
    ../bars/i3blocks
  ];

  hm.wayland.windowManager.sway.config.bars = [{
    statusCommand = "${pkgs.i3blocks}/bin/i3blocks -c ${config.hm.xdg.configHome}/i3blocks/i3blocks.conf";
    fonts = {
      names = [ "FontAwesome 11" "pango:Font-Awesome-6-Edited 11" "pango:Fira Mono for Powerline 11" ];
      style = "Regular";
      size = 11.0;
    };
    position = "top";
    colors = {
        background = config.theme.background;
        statusline = config.theme.foreground;
        separator = config.theme.third;
        inactiveWorkspace = {
          border = config.theme.background;
          background = config.theme.background;
          text = config.theme.foreground;
        };
        activeWorkspace = {
          border = config.theme.primary;
          background = config.theme.primary;
          text = config.theme.background;
        };
        focusedWorkspace = {
          border = config.theme.primary;
          background = config.theme.primary;
          text = config.theme.background;
        };
        urgentWorkspace = {
          border = config.theme.secondary;
          background = config.theme.secondary;
          text = config.theme.background;
        };
      };
  }];
}
