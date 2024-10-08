{ config, lib, pkgs, ... }:

{
  nixpkgs.overlays = [
    (self: super: {
      kitty-image-viewer-simplified = self.callPackage ./img.nix { };
    })
  ];

  environment.systemPackages = with pkgs; [
    kitty
    kitty-image-viewer-simplified
  ];

  hm.programs.kitty = {
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

      background = config.theme.background;
      foreground = config.theme.foreground;
      #selection_background = "#364A82";
      #selection_foreground = "#c0caf5";
      url_color = "#73daca";
      cursor = config.theme.primary;

      active_tab_background = "#7aa2f7";
      active_tab_foreground = "#1f2335";
      inactive_tab_background = "#292e42";
      inactive_tab_foreground = "#545c7e";

      color0 = config.theme.color0;
      color1 = config.theme.color1;
      color2 = config.theme.color2;
      color3 = config.theme.color3;
      color4 = config.theme.color4;
      color5 = config.theme.color5;
      color6 = config.theme.color6;
      color7 = config.theme.color7;
      color8 = config.theme.color8;
      color9 = config.theme.color9;
      color10 = config.theme.color10;
      color11 = config.theme.color11;
      color12 = config.theme.color12;
      color13 = config.theme.color13;
      color14 = config.theme.color14;
      color15 = config.theme.color15;
      #color16 = config.theme.color16;
      #color17 = config.theme.color17;

      #enabled_layouts = "Tall:bias=65, Fat:bias=65, Stack, Grid, Horizontal, Vertical";
      tab_bar_style = "fade";
      tab_fade = "1 1 1";
      term = "xterm-256color";
    };

    #theme = "Catppuccin-Mocha";
  };
}
