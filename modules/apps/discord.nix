{config, lib, pkgs, inputs, ... }:

{
  #environment.systemPackages = with pkgs; [
  #  vesktop
  #];

   hm.imports = [
     inputs.nixcord.homeManagerModules.nixcord
   ];

   hm.programs.nixcord = {
     enable = true;
     # disable discord (enabled by default)
     discord = {
       enable = false;
       vencord.enable = false;
       openASAR.enable = false;
     };
     # use vesktop instead (wayland optimized discord client)
     vesktop = {
       enable = true;
       package = pkgs.vesktop;
     };
     quickCss = /* css */ ''
.theme-dark {
  --accent-color: ${config.theme.primary};
  --background-1: ${config.theme.background};
  --background-2: ${config.theme.background};
  --background-accent: ${config.theme.foreground}11;
  --border-color: #273034;
}
.theme-light {
  --accent-color: ${config.theme.primary};
  --background-1: #ffffff;
  --background-2: #f5f7fa;
  --background-accent: var(--background-2);
  --border-color: transparent;
}


/* We <3 Squares! <> */
* {
  border-radius: 0 !important;
  image-rendering: pixelated !important;
  scrollbar-color: var(--accent-color) #181c20 !important;
  scrollbar-width: 10px !important;
}


/* Input blend in with chat background */
div[class^="channelTextArea"], div[class^="scrollableContainer"] {
  margin-top: 7px;
  background: transparent;
}
button[aria-label="Apps"] {
  background-color: transparent;
}
div#---new-messages-bar{
  border-color: var(--accent-color);
  margin-top: 10px !important;
  margin-bottom: 10px !important;
}
div[class^="divider"][role="separator"]{
  border-color: var(--accent-color);
  margin-top: 20px !important;
  margin-bottom: 20px !important;
}
div[class^="divider"] span[class^="content"]{
  font-size: 36px !important;
  color: var(--accent-color);
  margin-left: auto;
  margin-top: 20px;
  margin-bottom: 20px;
}
span[class^="unreadPill"]{
  right: unset;
  left: 0;
  overflow: hidden;
  background-color: var(--accent-color);
  color: var(--background-1);
  padding:4px;
}


/* Hide decoration shit */
[class^="avatarDecoration"]{
  display: none;
}
div[class^="modeSelected"] div[class^="channelName"]{
  color: var(--background-accent);
}
div[class^="profileEffects_"] {
  display: none;
}


/* Hide distractions */
div[class^="scroller_"] > div[style*="height: 56px"] {
    display: table-cell;
}
div[class^="unreadMentionsIndicatorBottom_"] {
    display: none;
}
div[class^="unreadMentionsIndicatorTop_"] {
    display: none;
}

/* Hide nitro shit */
div[class^="base_"] > div[class*="colorPremium_"] {
  display: none;
}
div[class^="buttons_"] > div[aria-label*="Nitro"] {
  display: none;
}
div[class^="premiumTrialAcknowledgedBadge_"] {
  display: none;
}
li[class^="channel_"]:has(a[href="/store"]) {
  display: none;
}
li[class^="channel_"]:has(a[href="/shop"]) {
  display: none;
}
div:has(+ div[class^="premiumTab_"]) {
  display: none;
}
div[class^="premiumTab_"] {
  display: none;
}
div[class^="premiumTab_"] + * {
  display: none;
}
div[aria-controls="nitro-server-boost-tab"] {
  display: none;
}
/* These depends on the language (German) */
button[aria-label="Ein Geschenk senden"] {
  display: none;
}
div[aria-label="Abonnements"] {
  display: none;
}
div[aria-label="Geschenkinventar"] {
  display: none;
}
div[aria-label="Zahlungsabwicklung"] {
  display: none;
}
div[aria-label="Zahlungsabwicklung"] + * {
  display: none;
}

/* Since nitro button is hidden in chat input box */
div.expression-picker-chat-input-button:has(button[class^="emojiButton"]){
  order: -1;
}
div[class^="inner_"] > div[class^="buttons_"] {
}
div[class^="channelAppLauncher_"] {
  margin-left: 0;
  margin-bottom: auto;
  margin-top: 16px;
}
div[class^="channelTextArea_"] > div[class^="scrollableContainer_"] {
  overflow-y: unset;
}
div[class^="channelTextArea_"] > div[class^="scrollableContainer_"] div[class^="textArea_"] {
  margin-right: 40px;
}

'';
     config = {
       themeLinks = [ "https://raw.githubusercontent.com/DiscordStyles/RadialStatus/deploy/RadialStatus.theme.css" ];
       useQuickCss = true;
       plugins = {
         #callTimer.enable = true;
         #crashHandler.enable = true;
         fakeNitro.enable = true;
         friendsSince.enable = true;
         notificationVolume.enable = true;
         volumeBooster.enable = true;
         webScreenShareFixes.enable = true;
         spotifyCrack.enable = true;
         typingTweaks.enable = true;
         USRBG.enable = true;
         oneko.enable = true;
         moreKaomoji.enable = true;
         anonymiseFileNames.enable = true;
         noBlockedMessages.enable = true;
       };
     };
   };
}
