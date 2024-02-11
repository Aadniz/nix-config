{ config, lib, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    adwaita-qt
    adwaita-qt6
    fuseiso
    gnome.adwaita-icon-theme
    gnome.gnome-themes-extra
    grim
    gsettings-desktop-schemas
    hyprland-protocols
    hyprpaper
    hyprpicker
    qt5.qtwayland
    qt6.qmake
    qt6.qtwayland
    swayidle
    swaylock
    swaynotificationcenter
    swww
    udiskie
    wl-clipboard
    wlr-randr
    wofi
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    xdg-utils
    ydotool
  ];

  environment.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    CLUTTER_BACKEND = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    GTK_USE_PORTAL = "1";
    NIXOS_XDG_OPEN_USE_PORTAL = "1";
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
  };

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };
}
