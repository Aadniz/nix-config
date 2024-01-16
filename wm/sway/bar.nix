{ config, lib, pkgs, theme, ... }:

let
  i3blocksConfigDir = "${config.xdg.configHome}/i3blocks";
  i3blocksConfigFile = "${i3blocksConfigDir}/i3blocks.conf";
in
{
  home.packages = with pkgs; [
    sysstat
    bc
    playerctl
    cmus
    rhythmbox
  ];

  imports = [(import ../bars/i3blocks { inherit i3blocksConfigDir i3blocksConfigFile theme; })];

  wayland.windowManager.sway.config.bars = [{
    statusCommand = "${pkgs.i3blocks}/bin/i3blocks -c ${i3blocksConfigFile}";
    fonts = {
      names = [ "pango:Fira Mono for Powerline" "FontAwesome 10" ];
      style = "Regular";
      size = 10.0;
    };
    position = "top";
    command = "${pkgs.sway}/bin/swaybar";
    colors = {
        background = theme.background;
        statusline = theme.foreground;
        separator = theme.third;
        inactiveWorkspace = {
          border = theme.background;
          background = theme.background;
          text = theme.foreground;
        };
        activeWorkspace = {
          border = theme.primary;
          background = theme.primary;
          text = theme.background;
        };
        focusedWorkspace = {
          border = theme.primary;
          background = theme.primary;
          text = theme.background;
        };
        urgentWorkspace = {
          border = theme.secondary;
          background = theme.secondary;
          text = theme.background;
        };
      };
  }];
}
