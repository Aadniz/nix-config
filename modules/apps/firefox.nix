{ config, lib, pkgs, ... }:

{
  hm.programs.firefox = {
    enable = true;
    profiles."default" = {
      id = 0;
      settings = {
        # Basic
        "browser.aboutConfig.showWarning" = false;                    # I know what I am doing, erm, most of the times...
        "browser.disableResetPrompt" = true;                          # Never seen this myself
        "browser.download.alwaysOpenPanel" = false;                   # Do not automatically open the download panel.
        "browser.download.useDownloadDir" = false;                    # Let me decide where to download the files.
        "browser.shell.checkDefaultBrowser" = false;                  # Let me handle the default.
        "browser.startup.homepage_override.mstone" = "ignore";        # Do not show the latest changes whenever there is an update
        "browser.tabs.firefox-view" = false;                          # I rarely have the need to sync tabs across devices. Plus, won't use a firefox account.
        "browser.toolbars.bookmarks.showInPrivateBrowsing" = true;    # Show bookmarks in private tabs as well.
        "browser.translations.automaticallyPopup" = false;            # Never prompt to translate a website
        "browser.urlbar.trimURLs" = false;                            # Always show http/https
        "extensions.autoDisableScopes" = "0";                         # Automatically enable extensions
        "services.sync.engine.passwords" = false;                     # I manage my passwords separately.
        "services.sync.prefs.sync.layout.spellcheckDefault" = false;  # Do not spell-check
        "signon.rememberSignons" = false;                             # Do not ask me to remember any password...

        # Extra Security
        #"privacy.globalprivacycontrol.functionality.enabled" = true;  # Private as much as possible.
        "privacy.trackingprotection.enabled" = true;                  # Do not track me.
        "privacy.donottrackheader.enabled" = true;                    # Do not track me.
        "geo.enabled" = false;                                        # Pretty much never give location data

        # Remjove ads
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.enhanced" = false;
        "browser.newtabpage.introShown" = true;
        "browser.newtab.preload" = false;
        "browser.newtabpage.directory.ping" = "";
        "browser.newtabpage.directory.source" = "data:text/plain,{}";

        ## Disable Pocket
        "extensions.pocket.enabled" = false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
      };


      search = {
        force = true;
        default = "Kantan";
        order = ["Invidious" "Kantan" "nixpkgs" "hm options search"];

        engines = {
          "Invidious" = {
            urls = [{template = "https://yewtu.be/search?q={searchTerms}";}];
            iconUpdateURL = "https://yewtu.be/favicon-32x32.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = ["@iv"];
          };

          "Kantan" = {
            urls = [{template = "https://kantan.cat/?q={searchTerms}";}];
            iconUpdateURL = "https://kantan.cat/static/themes/simple/img/favicon.svg";
            updateInterval = 24 * 60 * 60 * 1000; # every day
          };

          "nixpkgs" = {
            urls = [{template = "https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={searchTerms}";}];
            iconUpdateURL = "https://nixos.org/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = ["@np"];
          };
          "NixOS" = {
            urls = [{template = "https://search.nixos.org/options?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={searchTerms}";}];
            iconUpdateURL = "https://nixos.org/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = ["@nx"];
          };
          "MyNixOS" = {
            urls = [{template = "https://mynixos.com/search?q={searchTerms}";}];
            iconUpdateURL = "https://mynixos.com/favicon-16x16.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = ["@my"];
          };

          "hm options search" = {
            urls = [{template = "https://home-manager-options.extranix.com/?query={searchTerms}";}];
            iconUpdateURL = "https://home-manager-options.extranix.com/images/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = ["@hm"];
          };
          "Bing".metaData.hidden = true;
          "Google".metaData.hidden = true;
          "Amazon.com".metaData.hidden = true;
          "DuckDuckGo".metaData.hidden = true;
          "eBay".metaData.hidden = true;
        };
      };
    };
  };
}
