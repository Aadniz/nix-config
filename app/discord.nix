{
  config,
  lib,
  pkgs,
  theme,
  ...
}: let
  inherit (pkgs.stdenv) isDarwin isLinux;
in {
  config = {
    home.packages = with pkgs; [
      (discord.override {
        withOpenASAR = true;
      })
    ];
    home.activation.discordSettings = let
      css = /* css */ ''
:root {
  /* set to 'unset' to show */
  --scrollbars: none;
  /* user notes */
  --notes: none;
  /* direct message box */
  --message: none;
  /* set to '4px solid' to show */
  --embed-color: none;
  /* set to 'Inter', sans-serif !important to use Inter font*/
  --font-primary: Whitney, "Helvetica Neue", Helvetica, Arial, sans-serif;
  --font-display: Whitney, "Helvetica Neue", Helvetica, Arial, sans-serif !important;
  --border-radius-1: 0px;
  --border-radius-2: 0px;

  /* Colors */
  --white: #EFE4E7;
  --grey: #A79FA1;
  --highlight: #536988;
}
/*-----------CUSTOM COLORS-----------*/
/*-------------DARK MODE-------------*/
/*---------------BASIC---------------*/
.theme-dark {
  --accent-color: ${theme.primary};
  --background-1: ${theme.background};
  --background-2: ${theme.background};
  --background-accent: ${theme.foreground}11;
  --border-color: #273034;
}
/*-------------LIGHT MODE------------*/
.theme-light {
  --accent-color: ${theme.primary};
  --background-1: #ffffff;
  --background-2: #f5f7fa;
  --background-accent: var(--background-2);
  --border-color: transparent;
}
/*-------------ADVANCED--------------*/
.theme-dark {
  /* background */
  --background-primary: var(--background-1);
  --background-primary-alt: var(--background-1);
  --background-secondary: var(--background-2);
  --background-secondary-alt: var(--background-1);
  --background-tertiary: var(--background-2);
  --background-accent-gradient: var(--background-2);
  --background-floating: var(--background-1);
  --background-mentioned: #bde6fb10;
  --background-mentioned-hover: #bde6fb15;
  /* modifiers */
  --background-modifier-hover: var(--highlight);
  --background-modifier-active: var(--grey);
  --background-modifier-selected: var(--accent-color);
  --background-modifier-accent: transparent;
  --background-message-hover: transparent;
  /* text */
  --text-normal: var(--white);
  --text-positive: var(--text-normal);
  --text-muted: #6d8692;
  --text-link: #edf8fe;
  --interactive-selected: var(--background-primary);
  --interactive-active: var(--text-normal);
  --interactive-normal: var(--text-normal);
  --interactive-muted: var(--button-background-active);
  --channels-default: var(--text-muted);
  --header-primary: var(--text-normal);
  --header-secondary: var(--text-muted);
  /* more */
  --settings-icon-color: #8eacbc;
  --control-brand-foreground: var(--accent-color);
  --info-warning-foreground: var(--accent-color);
  --tab-selected: #354249;
  --switch: #3d4c53;
  --activity-card-background: var(--background-1);
  --brand-experiment: var(--accent-color) !important;
  /* buttons */
  --button-background: var(--background-1);
  --button-background-hover: var(--highlight);
  --button-background-active: var(--grey);
  --button-accent: var(--accent-color);
  --button-accent-hover: #d2f3ff;
  --button-accent-active: #8dd4f8;
  --button-destructive: #fb7c7c;
  --button-destructive-hover: #ff929b;
  --button-destructive-active: #fa4a4a;
}
.theme-light {
  /* background */
  --background-primary: var(--background-1);
  --background-primary-alt: var(--background-1);
  --background-secondary: var(--background-1);
  --background-secondary-alt: var(--background-1);
  --background-tertiary: var(--background-2);
  --background-accent-gradient: var(--background-2);
  --background-floating: var(--background-1);
  --background-mentioned: #22c5fd10;
  --background-mentioned-hover: #22c5fd15;
  /* modifiers */
  --background-modifier-hover: transparent;
  --background-modifier-active: #b7c2cc;
  --background-modifier-selected: var(--accent-color);
  --background-modifier-accent: transparent;
  --background-message-hover: transparent;
  /* text */
  --text-normal: #123354;
  --text-positive: var(--text-normal);
  --text-muted: #8495a7;
  --text-link: #15a6f0;
  --interactive-selected: var(--background-primary);
  --interactive-active: var(--text-normal);
  --interactive-normal: var(--text-normal);
  --interactive-muted: var(--text-muted);
  --channels-default: var(--text-normal);
  --header-primary: var(--text-normal);
  --header-secondary: var(--text-muted);
  /* more */
  --settings-icon-color: #566e86;
  --control-brand-foreground: var(--accent-color);
  --info-warning-foreground: var(--accent-color);
  --tab-selected: var(--background-1);
  --switch: #c8d0d9;
  --activity-card-background: var(--background-1);
  --brand-experiment: var(--accent-color) !important;
  /* buttons */
  --button-background: var(--background-1);
  --button-background-hover: #d3dae1;
  --button-background-active: #b1bcc8;
  --button-accent: var(--accent-color);
  --button-accent-hover: #22c5fd;
  --button-accent-active: #0d87c5;
  --button-destructive: #fb7c7c;
  --button-destructive-hover: #ff929b;
  --button-destructive-active: #fa4a4a;
}
/*-----------DON'T CHANGE------------*/
:root {
  --outdated-122: none !important;
}
/*  usrbg | snippet by _david_#0218  */
.userPopout-2j1gM4[style*="--user-background"] .banner-1YaD3N, .root-8LYsGj[style*="--user-background"] .banner-1YaD3N {
  height: 120px;
  background: var(--background-tertiary) var(--user-background) var(--user-popout-position, center) center / cover !important;
}
.root-8LYsGj[style*="--user-background"] .banner-1YaD3N {
  height: 240px;
}

* {
  border-radius: 0 !important;
  image-rendering: pixelated !important;
  scrollbar-color: var(--accent-color) #181c20 !important;
  scrollbar-width: 10px !important;
}
::before, ::after{
  opacity: 0;
}

div[class*="channelTextArea"], div[class*="scrollableContainer"] {
  margin-top: 7px;
  background: transparent;
}
div#---new-messages-bar{
  border-color: var(--accent-color);
  margin-top: 10px !important;
  margin-bottom: 10px !important;
}
div[class*="divider"]{
  border-color: var(--accent-color);
  margin-top: 20px !important;
  margin-bottom: 20px !important;
}
div[class*="divider"] span[class*="content"]{
  font-size: 36px !important;
  color: var(--accent-color);
  margin-left: auto;
  margin-top: 20px;
  margin-bottom: 20px;
}
span[class*="unreadPill"]{
  right: unset;
  left: 0;
  overflow: hidden;
  background-color: var(--accent-color);
  color: var(--background-1);
  padding:4px;
}
[class*="avatarDecoration"]{
  display: none;
}
main[class*="chatContent"] {
  transition-duration: 0.4s;
}
div#app-mount:hover main[class*="chatContent"] {
  background-color: var(--background-accent);
}
div[class*="modeSelected"] div[class*="channelName"]{
  color: var(--background-accent);
}
div[class^="profileEffects_"] {
  display: none;
}
div[class*="buttons_"] > div[aria-label*="Nitro"] {
  display: none;
}
div[class*="premiumTrialAcknowledgedBadge_"] {
  display: none;
}
      '';
      json = pkgs.writeTextFile {
        name = "discord-settings.json";
        text =
          lib.generators.toJSON {}
          {
            DANGEROUS_ENABLE_DEVTOOLS_ONLY_ENABLE_IF_YOU_KNOW_WHAT_YOURE_DOING = true;
            MIN_WIDTH = 0;
            MIN_HEIGHT = 0;
            openasar = {
              inherit css;
              setup = true;
            };
            trayBalloonShown = false;
            SKIP_HOST_UPDATE = true;
          };
      };
      path =
        if isLinux
        then config.xdg.configHome + "/discord/settings.json"
        else if isDarwin
        then config.home.homeDirectory + "/Library/Application Support/discord/settings.json"
        else throw "unsupported platform";
    in
      lib.hm.dag.entryAfter ["writeBoundary"] ''
        mkdir -p "$(dirname "${path}")"
        cp -f "${json}" "${path}"
      '';
  };
}
