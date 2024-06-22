{
  config,
  pkgs,
  lib,
  theme,
  ...
}: let
  toINI = lib.generators.toINI {};
  toINI' = lib.generators.toINIWithGlobalSection {};
in {
  # https://github.com/water-sucks/nixed/blob/ee7dbd01480d7fea173b050f2a757de2f3665ed1/home/profiles/graphical/fcitx5.nix
  #home.sessionVariables = {
  #  XMODIFIERS = "@im=fcitx";
  #  SDL_IM_MODULE = "fcitx";
  #  GLFW_IM_MODULE = "ibus"; # Fcitx5 has an IBus emulation mode, this is for IME in kitty to work.
  #};

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
        fcitx5-configtool
    ];
  };
  xdg.dataFile = {
    "fcitx5/themes/darkrose/arrow.png".source = ../theme/assets/arrow.png;
    "fcitx5/themes/darkrose/radio.png".source = ../theme/assets/radio.png;
    "fcitx5/themes/darkrose/theme.conf".text = toINI {
      "Metadata" = {
        Name = "darkrose";
        Version = 1;
        Author = "water-sucks";
        Description = "Low-contrast colorscheme that takes inspiration from rose colors";
        ScaleWithDPI = true;
      };

      InputPanel = {
        Font = "Sans 13";
        NormalColor = "${theme.foreground}";
        HighlightCandidateColor = "${theme.color2}";
        HighlightColor = "${theme.color2}";
        HighlightBackgroundColor = "${theme.color3}";
        Spacing = 3;
      };

      "InputPanel/TextMargin" = {
        Left = 10;
        Right = 10;
        Top = 7;
        Bottom = 7;
      };

      "InputPanel/Background" = {
        Color = "${theme.color8}";
        BorderColor = "${theme.color8}";
        BorderWidth = 2;
      };

      "InputPanel/Background/Margin" = {
        Left = 2;
        Right = 2;
        Top = 2;
        Bottom = 2;
      };

      "InputPanel/Highlight" = {
        Color = "${theme.background}";
      };

      "InputPanel/Highlight/Margin" = {
        Left = 10;
        Right = 10;
        Top = 7;
        Bottom = 7;
      };

      Menu = {
        Font = "Sans 12";
        NormalColor = "${theme.background}";
        HighlightColor = "${theme.primary}";
        Spacing = 3;
      };

      "Menu/Background" = {
        Color = "${theme.color3}";
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
        Color = "${theme.color5}";
      };

      "Menu/HighlightMargin" = {
        Left = 10;
        Right = 10;
        Top = 5;
        Bottom = 5;
      };

      "Menu/Separator" = {
        Color = "${theme.color6}";
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
  xdg.configFile = {
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
        "0" = "Control+/";
      };
      "Hotkey/DeactivateKeys" = {
        #"0" = "Control+<";
        "0" = "Control+/";
      };
    };
    "fcitx5/conf/classicui.conf".text = toINI' {
      globalSection = {
        Font = "IBM Plex Sans JP Text 12";
        MenuFont = "IBM Plex Sans JP Text 12";
        TrayFont = "IBM Plex Sans JP SmBld Demi-Bold 12";
        Theme = "darkrose";
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
        DefaultIM = "mozc";
      };

      "Groups/0/Items/0" = {
        # Name
        Name = "keyboard-no";
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

  # This is dangerous! It's a lazy workaround to delete files
  # after auto-writes to them from fcitx5's exit routines.
  # Scripts are explicitly not supposed to be called like this
  # according to the Home Manager manual, but I'm doing it it
  # anyway because it's more convenient. Also I'm lazy.
  home.activation = {
    delete-existing-fcitx5-files = lib.hm.dag.entryBefore ["checkLinkTargets"] ''
      rm $VERBOSE_ARG -rf $HOME/.config/fcitx5/* ~/.local/share/fcitx5/*
    '';
  };
}
