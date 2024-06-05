{ config, lib, pkgs, theme, ... }:

{
  home.packages = with pkgs; [
    element-desktop
  ];


  xdg.configFile."Element/config.json".text = builtins.toJSON {
    show_labs_settings = true;
    default_theme = "dark";
    setting_defaults.custom_themes = [
      {
        name = "Catppuccin Mocha";
        is_dark = true;
        colors = {
          "accent-color" = "${theme.primary}";
          "primary-color" = "${theme.secondary}";
          "warning-color" = "#FD3E3C";
          "alert" = "#FD3E3C";
          "sidebar-color" = "${theme.background}";
          "roomlist-background-color" = "${theme.background}";
          "roomlist-text-color" = "${theme.foreground}";
          "roomlist-text-secondary-color" = "${theme.secondary}";
          "roomlist-highlights-color" = "${theme.color8}";
          "roomlist-separator-color" = "#7f849c";
          "timeline-background-color" = "${theme.background}";
          "timeline-text-color" = "${theme.foreground}";
          "secondary-content" = "${theme.foreground}";
          "tertiary-content" = "${theme.foreground}";
          "timeline-text-secondary-color" = "${theme.secondary}";
          "timeline-highlights-color" = "#181825";
          "reaction-row-button-selected-bg-color" = "${theme.third}";
          "menu-selected-color" = "${theme.third}";
          "focus-bg-color" = "${theme.third}";
          "room-highlight-color" = "${theme.color8}";
          "togglesw-off-color" = "#9399b2";
          "other-user-pill-bg-color" = "${theme.color8}";
          "username-colors" = [
            "#cba6f7"
            "#eba0ac"
            "#fab387"
            "#a6e3a1"
            "#94e2d5"
            "${theme.color8}"
            "#74c7ec"
            "#b4befe"
          ];
          "avatar-background-colors" = [
            "#89b4fa"
            "#cba6f7"
            "#a6e3a1"
          ];
        };
      }
    ];
  };
}
