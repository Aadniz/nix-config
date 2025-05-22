{ config, lib, pkgs, ... }:

let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;
in
{

  hm.home.packages = with pkgs; [
    playerctl # CLI interface for playerctld
    mpc_cli # CLI interface for mpd
    cava
  ];

  hm.services = {
    mpd = {
      enable = true;
      musicDirectory = "/home/${config.username}/Music";

      network = {
        startWhenNeeded = true;
        listenAddress = "127.0.0.1";
        port = 6600;
      };

      extraConfig = ''
        auto_update           "yes"
        volume_normalization  "yes"
        restore_paused        "yes"
        filesystem_charset    "UTF-8"

        audio_output {
          type                "pipewire"
          name                "PipeWire"
        }

        audio_output {
          type                "fifo"
          name                "Visualiser"
          path                "/tmp/mpd.fifo"
          format              "44100:16:2"
        }

        audio_output {
         type                 "httpd"
         name                 "lossless"
         encoder              "flac"
         port                 "8000"
         max_clients          "8"
         mixer_type           "software"
         format               "44100:16:2"
        }
      '';
    };

    mpd-mpris.enable = true;
    mpris-proxy.enable = true;
    # TODO: move to nixos service?
    # playerctld.enable = true;

    # MPRIS 2 support to mpd
    mpdris2 = {
      enable = true;
      notifications = true;
      multimediaKeys = true;
      mpd = {
        # inherit (config.services.mpd) musicDirectory;
        musicDirectory = null;
      };
    };

    # discord rich presence for mpd
    mpd-discord-rpc = {
      enable = false;

      settings = {
        format = {
          details = "$title";
          state = "On $album by $artist";
          large_text = "$album";
          small_image = "";
        };
      };
    };
  };

}
