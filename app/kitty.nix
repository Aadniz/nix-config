{ config, lib, pkgs, theme, ... }:

{

  home.packages = with pkgs; [
    kitty
  ];

programs.kitty = {
    enable = true;
    font = {
      size = 10;
      name = "Fira code";
    };

    settings = {
      scrollback_lines = 10000;
      placement_strategy = "center";

      allow_remote_control = "yes";
      enable_audio_bell = "no";
      visual_bell_duration = "0.1";

      copy_on_select = "clipboard";

      selection_foreground = "none";
      selection_background = "none";

      # colors
      background_opacity = "0.95";

      background = theme.background;
      foreground = theme.foreground;
      #selection_background = "#364A82";
      #selection_foreground = "#c0caf5";
      url_color = "#73daca";
      cursor = theme.primary;

      active_tab_background = "#7aa2f7";
      active_tab_foreground = "#1f2335";
      inactive_tab_background = "#292e42";
      inactive_tab_foreground = "#545c7e";

      color0 = theme.colors.color0;
      color1 = theme.colors.color1;
      color2 = theme.colors.color2;
      color3 = theme.colors.color3;
      color4 = theme.colors.color4;
      color5 = theme.colors.color5;
      color6 = theme.colors.color6;
      color7 = theme.colors.color7;
      color8 = theme.colors.color8;
      color9 = theme.colors.color9;
      color10 = theme.colors.color10;
      color11 = theme.colors.color11;
      color12 = theme.colors.color12;
      color13 = theme.colors.color13;
      color14 = theme.colors.color14;
      color15 = theme.colors.color15;
      #color16 = theme.colors.color16;
      #color17 = theme.colors.color17;
    };

    #theme = "Catppuccin-Mocha";
  };
}
