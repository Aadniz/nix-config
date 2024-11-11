{config, lib, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    vesktop
  ];

  ## Doesn't work
  ## hm.imports = [
  ##   inputs.nixcord.homeManagerModules.nixcord
  ## ];

  ## hm.programs.nixcord = {
  ##   enable = true;
  ##   # disable discord (enabled by default)
  ##   discord = {
  ##     enable = false;
  ##     vencord.enable = false;
  ##     openASAR.enable = false;
  ##   };
  ##   # use vesktop instead (wayland optimized discord client)
  ##   vesktop = {
  ##     enable = true;
  ##     package = pkgs.vesktop;
  ##   };
  ##   config.plugins = {
  ##     callTimer.enable = true;
  ##     crashHandler.enable = true;
  ##     fakeNitro.enable = true;
  ##     friendsSince.enable = true;
  ##     notificationVolume.enable = true;
  ##     volumeBooster.enable = true;
  ##     webScreenShareFixes.enable = true;
  ##     spotifyCrack.enable = true;
  ##     typingTweaks.enable = true;
  ##     USRBG.enable = true;
  ##     oneko.enable = true;
  ##     moreKaomoji.enable = true;
  ##     anonymiseFileNames.enable = true;
  ##     noBlockedMessages.enable = true;
  ##   };
  ## };
}
