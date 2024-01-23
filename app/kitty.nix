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

    keybindings = {
      "kitty_mod+s" = "next_window";
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

      color0 = theme.color0;
      color1 = theme.color1;
      color2 = theme.color2;
      color3 = theme.color3;
      color4 = theme.color4;
      color5 = theme.color5;
      color6 = theme.color6;
      color7 = theme.color7;
      color8 = theme.color8;
      color9 = theme.color9;
      color10 = theme.color10;
      color11 = theme.color11;
      color12 = theme.color12;
      color13 = theme.color13;
      color14 = theme.color14;
      color15 = theme.color15;
      #color16 = theme.colors.color16;
      #color17 = theme.colors.color17;

      #enabled_layouts = "Tall:bias=65, Fat:bias=65, Stack, Grid, Horizontal, Vertical";
      tab_bar_style = "fade";
      tab_fade = "1 1 1";
      term = "xterm-256color";
    };

    #theme = "Catppuccin-Mocha";
  };
}
