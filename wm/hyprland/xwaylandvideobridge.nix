{
  lib,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland.settings.windowrulev2 = [
    "opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
    "noanim,class:^(xwaylandvideobridge)$"
    "noinitialfocus,class:^(xwaylandvideobridge)$"
    "maxsize 1 1,class:^(xwaylandvideobridge)$"
    "noblur,class:^(xwaylandvideobridge)$"
  ];

  systemd.user.services.xwaylandvideobridge = {
    Unit.Description = "XWaylandVideoBridge";
    Service.ExecStart = lib.getExe pkgs.xwaylandvideobridge;
    Install.WantedBy = ["graphical-session.target"];
  };
}
