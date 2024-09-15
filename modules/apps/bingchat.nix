{ config, lib, pkgs, ... }:

let
  bingchat = pkgs.writeShellScriptBin "bingchat" ''
    ${lib.getExe pkgs.microsoft-edge} --app='https://www.bing.com/search?q=Bing+AI&showconv=1'
  '';
in
{
  environment.systemPackages = [ bingchat ];

  hm.xdg.desktopEntries."bingchat" = {
    name = "Bing AI";
    comment = "Minimalistic free GPT-4 without microsoft junk";
    #icon = "??";
    exec = (lib.getExe bingchat);
    #categories = [ "AI" "GPT-4" ];
    terminal = false;
  };
}
