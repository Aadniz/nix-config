{ config, lib, pkgs, ... }:
let
  bg = config.theme.foreground;
  fg = config.theme.background;
  hi = config.theme.primary;
  urgent = config.theme.color5;
in
{
  environment.systemPackages = with pkgs; [ mako ];
  hm.services.mako = {
    enable = true;
    settings = {
      background-color = bg;
      progress-color = "over ${hi}FF";
      border-size = 0;
      width = 400;
      height = 300;
      padding = "16";
      #margin = "60,30";
      default-timeout = 7000;
      font = "Monospace 12";
      layer = "overlay";
      sort = "+time";
      max-visible = 6;
      text-color = fg;
      #extraConfig = /* ini */ ''
      #  [urgency=high]
      #  border-color=${urgent}
      #  border-size=3
      #  default-timeout=0
      #  [urgency=critical]
      #  border-color=${urgent}
      #  border-size=3
      #  default-timeout=0
      #'';
    };
  };
}
