{ config, lib, pkgs, ... }:

{
  imports = [
    ./theme.nix
  ];

  services.xserver.desktopManager.runXdgAutostartIfNone = true;

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
      ];
      waylandFrontend = true;
    };
  };

  hm.wayland.windowManager.sway.config.startup = [ { command = "fcitx5"; } ];

  # This is dangerous! It's a lazy workaround to delete files
  # after auto-writes to them from fcitx5's exit routines.
  # Scripts are explicitly not supposed to be called like this
  # according to the Home Manager manual, but I'm doing it it
  # anyway because it's more convenient. Also I'm lazy.
  hm.home.activation = {
    "delete-existing-fcitx5-files" = {
      before = [ "checkLinkTargets" ];
      after = [ ];
      data = "rm $VERBOSE_ARG -rf $HOME/.config/fcitx5/* ~/.local/share/fcitx5/*";
    };
  };
}
