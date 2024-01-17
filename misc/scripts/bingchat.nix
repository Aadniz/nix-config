{ config, lib, pkgs, ... }:
# Free GPT-4 without microsoft junk
let
  bingchat = pkgs.writeShellScriptBin "bingchat" ''
    #!/bin/bash
    ${pkgs.microsoft-edge-dev}/bin/microsoft-edge-dev --app='https://www.bing.com/search?q=Bing+AI&showconv=1'
  '';
in
{
  home.packages = [ bingchat ];
}
