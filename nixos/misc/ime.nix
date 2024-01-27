{ config, lib, pkgs, ...}:

# https://functor.tokyo/blog/2018-10-01-japanese-on-nixos

{
  imports = [];

  #############################################################
  ## Select internationalisation properties for the console. ##
  #############################################################

  # The font to be used on the console when logging in.  Since most people
  # only use Japanese in X, you can leave this as the default value.
  console.font = "Lat2-Terminus16";

  # The keymap to be used on the console.  Unless you use a special keyboard
  # layout, you can leave this as the default value.
  console.keyMap = "no";

  # The locale to use by default.  Any locale is fine as long as the character
  # set is "UTF-8".  If you want applications on your system to use Japanese by
  # default, you could set the value to "ja_JP.UTF-8".
  i18n.defaultLocale = "en_US.UTF-8";



  ###############################
  ## Input Method Editor (IME) ##
  ###############################

  # This enables "fcitx" as your IME.  This is an easy-to-use IME.  It supports many different input methods.
  i18n.inputMethod.enabled = "fcitx5";

  # This enables "mozc" as an input method in "ibus".
  i18n.inputMethod.fcitx5.addons = with pkgs; [ fcitx5-mozc ];
}
