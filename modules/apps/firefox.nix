{ config, lib, pkgs, ... }:

{
  hm.programs.firefox = {
    enable = true;
    profiles."default" = {
      id = 0;
      settings = {
        # If you're having issues finding the option for the setting you want to change, you can save before and after, then diff
        # 1. cat ~/.mozilla/firefox/default/prefs.js > /tmp/prefs_before.js
        # 2. Change the setting(s)
        # 3. cat ~/.mozilla/firefox/default/prefs.js > /tmp/prefs_after.js
        # 4. diff /tmp/prefs_before.js /tmp/prefs_after.js

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

        # Max DNS protection
        "doh-rollout.disable-heuristics" = true;
        "network.trr.mode" = "3";
        "network.trr.custom_uri" = "https://dns.mullvad.net/dns-query";
        "network.trr.uri" = "https://dns.mullvad.net/dns-query";

        # Remjove ads
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.enhanced" = false;
        "browser.newtabpage.introShown" = true;
        "browser.newtab.preload" = false;
        "browser.newtabpage.directory.ping" = "";
        "browser.newtabpage.directory.source" = "data:text/plain,{}";

        # Disable Pocket
        "extensions.pocket.enabled" = false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;

        # Allows changing of firefox CSS
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };

      userContent = /* css */ ''
          @namespace url("http://www.w3.org/1999/xhtml");
          @-moz-document url("about:home") ,url("about:blank"), url("about:newtab") {
            :root {
              --newtab-background-color-secondary: #2b2a30 !important;
            }

            body {
              /* background-color: ${config.theme.background} !important; */
              background-color: #424146 !important;
            }
            div.search-wrapper {
              padding: unset !important;
            }
            div.non-collapsible-section {
              margin-top: -30px;
            }
            div.logo-and-wordmark {
              margin-block: 20px -35px !important;
              background: no-repeat url("${../../assets/sussuro_logo.png}?raw=true") center;
              background-size: contain;
              height: 30vh;
            }
            div.logo-and-wordmark .logo,
            div.logo-and-wordmark .wordmark {
              display: none !important;
            }
            div.search-inner-wrapper {
              width: 100% !important;
              padding: 0 7px;
            }
            button.search-handoff-button {
              border-color: #e1746d !important;
            }
            .top-site-button > div.tile {
              outline-color: #e1746d !important;
              background-color: transparent !important;
              height: unset !important;
              width: unset !important;
              box-shadow: none !important;
            }
            div.top-site-icon {
              background-color: transparent !important;
            }
          }
      '';

      userChrome = ''

          /* Disable elements  */
          #context-navigation,
          #context-pocket,
          #context-sendpagetodevice,
          #context-sendlinktodevice,
          #context-openlinkinusercontext-menu,
          #context-bookmarklink,
          #context-savelink,
          #context-savelinktopocket,
          #context-sendlinktodevice,
          #context-sendimage,
          #context-inspect-a11y,
          #context-print-selection {
            display: none !important;
          }

          #context_bookmarkTab,
          #context_moveTabOptions,
          #context_sendTabToDevice,
          #context_reopenInContainer,
          #context_selectAllTabs,
          #context_closeTabOptions {
            display: none !important;
          }

          /* Remove titlebar close button */
          .titlebar-buttonbox-container,
          .titlebar-spacer[type="post-tabs"] {
            display: none !important;
          }

          /* Remove space around the address box*/
          #nav-bar toolbarspring {
            min-width: 0px !important;
            max-width: 0px !important;
          }
      '';

      search = {
        force = true;
        default = "Kantan";
        order = ["Invidious" "Kantan" "nixpkgs" "hm options search"];

        engines = {
          "Invidious" = {
            urls = [{template = "https://inv.nadeko.net/search?q={searchTerms}";}];
            icon = "https://inv.nadeko.net/favicon-32x32.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = ["@iv"];
          };

          "Kantan" = {
            urls = [{template = "https://kantan.cat/?q={searchTerms}";}];
            icon = "https://kantan.cat/static/themes/simple/img/favicon.svg";
            updateInterval = 24 * 60 * 60 * 1000; # every day
          };

          "nixpkgs" = {
            urls = [{template = "https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={searchTerms}";}];
            icon = "https://nixos.org/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = ["@np"];
          };
          "NixOS" = {
            urls = [{template = "https://search.nixos.org/options?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={searchTerms}";}];
            icon = "https://nixos.org/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = ["@nx"];
          };
          "MyNixOS" = {
            urls = [{template = "https://mynixos.com/search?q={searchTerms}";}];
            icon = "https://mynixos.com/favicon-16x16.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = ["@my"];
          };

          "hm options search" = {
            urls = [{template = "https://home-manager-options.extranix.com/?query={searchTerms}";}];
            icon = "https://home-manager-options.extranix.com/images/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = ["@hm"];
          };
          "bing".metaData.hidden = true;
          "google".metaData.hidden = true;
          "amazondotcom-us".metaData.hidden = true;
          "ddg".metaData.hidden = true;
          "ebay".metaData.hidden = true;
        };
      };
    };
  };
}
