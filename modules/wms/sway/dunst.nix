{
  pkgs,
  config,
  lib,
  ...
}:
let
  dunstbg = config.theme.foreground;
  dunstfg = config.theme.background;
  dunsthi = config.theme.primary;
  dunsturgent = config.theme.color5;
  dunstrc = pkgs.lib.generators.toINI {} {
    urgency_low = {
      background = ''"${dunstbg}"'';
      foreground = ''"${dunstfg}"'';
      highlight = ''"${dunsthi}"'';
      timeout = 3;
      # Icon for notifications with low urgency, uncomment to enable
      #default_icon = "/path/to/icon";
    };

    urgency_normal = {
      timeout = 10;
      background = ''"${dunstbg}"'';
      foreground = ''"${dunstfg}"'';
    };

    urgency_critical = {
      background = ''"${dunstbg}"'';
      foreground = ''"${dunstfg}"'';
      frame_color = ''"${dunsturgent}"'';
      timeout = 0;
    };

    global = {
      transparency = 0;

      font = "Monospace 12";

      width = 400;
      # The maximum height of a single notification, excluding the frame.
      # height = 50;
      # Position the notification in the top right corner
      origin = "top-right";

      # Offset from the origin
      offset = "(30, 60)";

      # Scale factor. It is auto-detected if value is 0.
      scale = 0;

      # Maximum number of notification (0 means no limit)
      notification_limit = 0;
      monitor = 0;
      follow = "mouse";
      progress_bar = true;
      # Set the progress bar height. This includes the frame, so make sure
      # it's at least twice as big as the frame width.
      progress_bar_height = 10;
      progress_bar_frame_width = 1;
      progress_bar_min_width = 150;
      progress_bar_max_width = 300;
      indicate_hidden = "yes";

      # Draw a line of "separator_height" between notifs
      separator_height = 0;
      # Padding between text and separator.
      padding = 16;
      horizontal_padding = 16;
      text_icon_padding = 0;
      frame_width = 2; # no frame / no border
      frame_color = ''"${dunstbg}"'';
      separator_color = "frame";
      sort = "no"; # by urgency

      # The format of the message.  Possible variables are:
      #   %a  appname
      #   %s  summary
      #   %b  body
      #   %i  iconname (including its path)
      #   %I  iconname (without its path)
      #   %p  progress value if set ([  0%] to [100%]) or nothing
      #   %n  progress value if set without any extra characters
      #   %%  Literal %
      # Markup is allowed
      format = ''"<b>%s</b>\n%b"'';

      # Possible values are "left", "center" and "right".
      alignment = "left";
      # Possible values are "top", "center" and "bottom".
      vertical_alignment = "center";
      # Show age of message if message is older than show_age_threshold
      # seconds.
      # Set to -1 to disable.
      show_age_threshold = 60;
      # Specify where to make an ellipsis in long lines.
      # Possible values are "start", "middle" and "end".
      ellipsize = "middle";
      ignore_newline = "no";
      stack_duplicates = true;
      hide_duplicate_count = false;
      # Display indicators for URLs (U) and actions (A).
      show_indicators = "yes";

      # ICONS -------------------------------------------------------------
      # Align icons left/right/off
      icon_position = "left";
      min_icon_size = 0;
      # Scale larger icons down to this size, set to 0 to disable
      max_icon_size = 32;
      # Paths to default icons.
      #icon_path = "/usr/share/icons/gnome/16x16/status/:/usr/share/icons/gnome/16x16/devices/";

      ### HISTORY ###
      # Should a notification popped up from history be sticky or timeout
      # as if it would normally do.
      sticky_history = "yes";
      history_length = 20;

      ### Misc/Advanced ###

      # Browser for opening urls in context menu.
      browser = "${pkgs.xdg-utils}/bin/xdg-open";
      # dmenu path.
      dmenu = "/usr/bin/dmenu -p dunst:";
      # Define the title of the windows spawned by dunst
      title = "Notification";
      # Define the class of the windows spawned by dunst
      class = "Dunst";
      corner_radius = 0;

      ignore_dbusclose = false;
      always_run_script = true;
      force_xwayland = false;
      force_xinerama = false;
      mouse_left_click = "close_current";
      mouse_middle_click = "do_action, close_current";
      mouse_right_click = "close_all";
    };

    experimental = {
      per_monitor_dpi = false;
    };
  };
in
{

  config = lib.mkIf config.services.sway.enable {
    hm.home.file.".config/dunst/dunstrc".text = dunstrc;

    environment.systemPackages = with pkgs; [
      dunst
      libnotify
      glib
    ];

    systemd.user.services."dunst" = {
      enable = true;
      description = "";
      wantedBy = [ "default.target" ];
      serviceConfig.Restart = "always";
      serviceConfig.RestartSec = 2;
      serviceConfig.ExecStart = "${pkgs.dunst}/bin/dunst";
    };
  };
}
