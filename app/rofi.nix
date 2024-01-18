  { config, pkgs, theme, ... }:

{
  programs.rofi = {
    enable = true;
    cycle = false;

    package = pkgs.rofi-wayland;

    extraConfig = {
      modi = "drun,filebrowser";
      font = "Noto Sans CJK JP 12";
      show-icons = false;
      bw = 0;
      display-drun = "";
      display-window = "";
      display-combi = "";
      icon-theme = "Fluent-dark";
      terminal = "kitty";
      drun-match-fields = "name";
      drun-display-format = "{name}";
      me-select-entry = "";
      me-accept-entry = "MousePrimary";
    };

    # Based on Newman Sánchez's Launchpad theme <https://github.com/newmanls/rofi-themes-collection>
    theme = let inherit (config.lib.formats.rasi) mkLiteral; in {
      "*" = {
        font = "Noto Sans CJK JP Bold 12";
        background-color = mkLiteral "transparent";
        foreground = mkLiteral "${theme.foreground}";
        text-color = mkLiteral "${theme.foreground}";
        padding = mkLiteral "0px";
        margin = mkLiteral "0px";
      };

      window = {
        fullscreen = true;
        padding = mkLiteral "1em";
        background-color = mkLiteral "${theme.background}dd";
      };

      mainbox = {
        padding = mkLiteral "8px";
      };

      inputbar = {
        background-color = mkLiteral "${theme.foreground}20";

        margin = mkLiteral "0px calc( 50% - 230px )";
        padding = mkLiteral "4px 8px";
        spacing = mkLiteral "8px";

        border = mkLiteral "1px";
        border-radius = mkLiteral "0px";
        border-color = mkLiteral "${theme.foreground}40";

        children = map mkLiteral [ "icon-search" "entry" ];
      };

      prompt = {
        enabled = false;
      };

      icon-search = {
        expand = false;
        filename = "search";
        vertical-align = mkLiteral "0.5";
      };

      entry = {
        placeholder = "Search";
        placeholder-color = mkLiteral "${theme.foreground}20";
      };

      listview = {
        margin = mkLiteral "48px calc( 50% - 720px )";
        margin-bottom = mkLiteral "0px";
        spacing = mkLiteral "48px";
        columns = 6;
        fixed-columns = true;
      };

      "element, element-text, element-icon" = {
        cursor = mkLiteral "pointer";
      };

      element = {
        padding = mkLiteral "8px";
        spacing = mkLiteral "4px";

        orientation = mkLiteral "vertical";
        border-radius = mkLiteral "0px";
      };

      "element selected" = {
        background-color = mkLiteral "${theme.primary}33";
        text-color = mkLiteral "${theme.primary}";
      };

      element-icon = {
        size = mkLiteral "5.75em";
        horizontal-align = mkLiteral "0.5";
      };

      element-text = {
        horizontal-align = mkLiteral "0.5";
      };
    };
  };
}
