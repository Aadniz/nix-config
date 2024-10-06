{ config, lib, pkgs, ... }:
let
  themeName = "custom";
  toINI = lib.generators.toINI {};
  toINI' = lib.generators.toINIWithGlobalSection {};
in
{
  hm.xdg.dataFile = {
    "fcitx5/themes/${themeName}/arrow.png".source = ./arrow.png;
    "fcitx5/themes/${themeName}/radio.png".source = ./radio.png;
    "fcitx5/themes/${themeName}/theme.conf".text = toINI {
      "Metadata" = {
        Name = themeName;
        Version = 1;
        Author = "water-sucks";
        Description = "Low-contrast colorscheme that takes inspiration from rose colors";
        ScaleWithDPI = true;
      };

      InputPanel = {
        Font = "Sans 13";
        NormalColor = "${config.theme.foreground}";
        HighlightCandidateColor = "${config.theme.color2}";
        HighlightColor = "${config.theme.color2}";
        HighlightBackgroundColor = "${config.theme.color3}";
        Spacing = 3;
      };

      "InputPanel/TextMargin" = {
        Left = 10;
        Right = 10;
        Top = 7;
        Bottom = 7;
      };

      "InputPanel/Background" = {
        Color = "${config.theme.color8}";
        BorderColor = "${config.theme.color8}";
        BorderWidth = 2;
      };

      "InputPanel/Background/Margin" = {
        Left = 2;
        Right = 2;
        Top = 2;
        Bottom = 2;
      };

      "InputPanel/Highlight" = {
        Color = "${config.theme.background}";
      };

      "InputPanel/Highlight/Margin" = {
        Left = 10;
        Right = 10;
        Top = 7;
        Bottom = 7;
      };

      Menu = {
        Font = "Sans 12";
        NormalColor = "${config.theme.background}";
        HighlightColor = "${config.theme.primary}";
        Spacing = 3;
      };

      "Menu/Background" = {
        Color = "${config.theme.color3}";
      };

      "Menu/Background/Margin" = {
        Left = 2;
        Right = 2;
        Top = 2;
        Bottom = 2;
      };

      "Menu/ContentMargin" = {
        Left = 2;
        Right = 2;
        Top = 2;
        Bottom = 2;
      };

      "Menu/Highlight" = {
        Color = "${config.theme.color5}";
      };

      "Menu/HighlightMargin" = {
        Left = 10;
        Right = 10;
        Top = 5;
        Bottom = 5;
      };

      "Menu/Separator" = {
        Color = "${config.theme.color6}";
      };

      "Menu/CheckBox" = {
        Color = "radio.png";
      };

      "Menu/SubMenu" = {
        Image = "arrow.png";
      };

      "Menu/TextMargin" = {
        Left = 5;
        Right = 5;
        Top = 5;
        Bottom = 5;
      };
    };
  };

  # Configuring input engines here directly.
  # Kinda cumbersome to use but it is what it is
  hm.xdg.configFile = {
    "fcitx5/conf/xcb.conf".text = "Allow Overriding System XKB Settings=False";
    "fcitx5/config".text = toINI {
      Hotkey = {
        TriggerKeys = "";
        EnumerateWithTriggerKeys = true;
        AltTriggerKeys = "";
        EnumerateForwardKeys = "";
        EnumerateBackwardKeys = "";
        EnumerateSkipFirst = false;
        EnumerateGroupForwardKeys = "";
        EnumerateGroupBackwardKeys = "";
      };
      "Hotkey/ActivateKeys" = {
        #"0" = "Control+<";
        "0" = "Control+\\\\";
      };
      "Hotkey/DeactivateKeys" = {
        #"0" = "Control+<";
        "0" = "Control+\\\\";
      };
    };
    "fcitx5/conf/classicui.conf".text = toINI' {
      globalSection = {
        Font = "IBM Plex Sans JP Text 12";
        MenuFont = "IBM Plex Sans JP Text 12";
        TrayFont = "IBM Plex Sans JP SmBld Demi-Bold 12";
        Theme = themeName;
      };
      sections = {};
    };
    "fcitx5/profile".text = toINI {
      "Groups/0" = {
        # Group Name
        "Name" = "Default";
        # Layout
        "Default Layout" = "no";
        # Default Input Method
        DefaultIM = "keyboard-us-altgr-intl";
      };

      "Groups/0/Items/0" = {
        # Name
        Name = "keyboard-us-altgr-intl";
        # Layout
        Layout = "";
      };

      "Groups/0/Items/1" = {
        # Name
        Name = "mozc";
        # Layout
        Layout = "";
      };

      GroupOrder = {
        "0" = "Default";
      };
    };
  };
}
