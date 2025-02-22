{ config, lib, pkgs, ... }:

let
  grok = pkgs.writeShellScriptBin "grok" ''
    ${lib.getExe pkgs.chromium} --app='https://x.com/i/grok?focus'
  '';
in
{
  environment.systemPackages = [ grok ];

  hm.xdg.desktopEntries."grok" = {
    name = "Grok AI";
    comment = "Minimalistic free GROK AI chat without Twitter bloat";
    exec = (lib.getExe grok);
    terminal = false;
  };
}
