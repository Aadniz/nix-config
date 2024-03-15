{ config, lib, pkgs, ... }:

let
  bingchat = pkgs.writeShellScriptBin "bingchat" ''
    ${pkgs.microsoft-edge-dev}/bin/microsoft-edge-dev --app='https://www.bing.com/search?q=Bing+AI&showconv=1'
  '';
in
{
  home.packages = [ bingchat ];

  xdg.desktopEntries."bingchat" = {
    name = "Bing AI";
    comment = "Minimalistic free GPT-4 without microsoft junk";
    #icon = "??";
    exec = (lib.getExe bingchat);
    #categories = [ "AI" "GPT-4" ];
    terminal = false;
  };
}
