{ config, lib, pkgs, ... }:

{
  hm.programs.thunderbird = {
    enable = true;
    profiles = {
      "main" = {
        isDefault = true;
        settings = {
          calendar.alarms.showmissed = false;
          calendar.alarms.playsound = false;
          calendar.alarms.show = false;

          middlemouse.paste = false;
          general.autoScroll = true;

          extensions.webcompat-reporter.enabled = false;

          media.ffmpeg.vaapi.enabled = true;

          findbar.highlightAll = true;

          dom = {
            security.https_only_mode = true;
            push.connection.enabled = false;
            battery.enabled = false;
          };

          privacy = {
            globalprivacycontrol.enabled = true;
            clearOnShutdwon.cache = true;
            fingerprintingProtection = true;
            donottrackheader.enabled = true;
            trackingprotection = {
              fingerprinting.enabled = true;
              socialtracking.enabled = true;
              cryptomining.enabled = true;
              emailtracking.enabled = true;
            };

            beacon.enabled = false;
            device.sensors.enabled = false;
            geo.enabled = false;

            network.predictor.enabled = false;

            toolkit.telemetry = {
              unified = false;
              server = "";
              owner = "";
              newProfilePing.enabled = false;
              updatePing.enabled = false;
              shutdownPingSender.enabled = false;
              archive.enabled = false;
              bhrPing.enabled = false;
            };

            datareporting = {
              policy.dataSubmissionEnabled = false;
              healthreport.uploadEnabled = false;
            };
          };
          search = {
            force = true;
            default = "Kantan";
            order = ["Invidious" "Kantan" "nixpkgs" "hm options search"];

            engines = {
              "Kantan" = {
                urls = [{template = "https://kantan.cat/?q={searchTerms}";}];
                iconUpdateURL = "https://kantan.cat/static/themes/simple/img/favicon.svg";
                updateInterval = 24 * 60 * 60 * 1000; # every day
              };
            };
          };
        };
      };
    };
  };
}
