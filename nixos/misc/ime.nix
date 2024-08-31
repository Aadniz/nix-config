{ config, lib, pkgs, ...}:

# https://functor.tokyo/blog/2018-10-01-japanese-on-nixos

{

  # The font to be used on the console when logging in.  Since most people
  # only use Japanese in X, you can leave this as the default value.
  console.font = "Lat2-Terminus16";

  # The keymap to be used on the console.  Unless you use a special keyboard
  # layout, you can leave this as the default value.
  console.keyMap = "no";

  services.xserver.desktopManager.runXdgAutostartIfNone = true;

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "ja_JP.UTF-8/UTF-8"
    ];
    inputMethod = {
      type = "fcitx5";
      fcitx5.addons = with pkgs; [fcitx5-mozc];
    };
  };
}
