{ config, lib, pkgs, ... }:

{
  imports = [
    ./hyprland.nix
  ];

  environment.systemPackages = with pkgs; [
#    gnome.gdm
    qt5.qtwayland
    qt5.full
    qt6.qmake
    qt6.qtwayland
    sddm
  ];

  # Environment variables
  #environment = {
  #  variables = {
  #    QT_QPA_PLATFORMTHEME = "qt5ct";
  #    QT_QPA_PLATFORM = "xcb obs";
  #  };
  #};
  # Enable the X11 windowing system.
  #services.xserver.enable = true;

  # Login menu
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;


  services.xserver = {
    layout = "no";
    xkbVariant = "";
    enable = true;
    displayManager.sddm = {
      enable = true;
      autoNumlock = true;
    };
  };

  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "dbus-run-session Hyprland";
        user = "chiya";
      };
      default_session = initial_session;
    };
  };
}
