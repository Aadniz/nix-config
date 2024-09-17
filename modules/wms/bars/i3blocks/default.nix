{ config, pkgs, ... }:
let
  i3blocksConfigDir = "${config.hm.xdg.configHome}/i3blocks";
  i3blocksConfigFile = "${i3blocksConfigDir}/i3blocks.conf";
  dateScript = "${i3blocksConfigDir}/date";
  audioScript = "${i3blocksConfigDir}/volume-pulseaudio";
  memoryScript = "${i3blocksConfigDir}/memory";
  cpuScript = "${i3blocksConfigDir}/cpu_usage";
  mediaplayerScript = "${i3blocksConfigDir}/mediaplayer";
  statusScript = "${i3blocksConfigDir}/status_script";
  python-zmq-packages = ps: with ps; [ python.pkgs.pyzmq ];
  python-zmq = pkgs.python3.withPackages python-zmq-packages;
in
{
  environment.systemPackages = with pkgs; [
    sysstat
    bc
    playerctl
    cmus
    rhythmbox
  ];

  hm.home.file."${dateScript}".source = ./date;
  hm.home.file."${audioScript}".source = ./volume-pulseaudio;
  hm.home.file."${memoryScript}".source = ./memory;
  hm.home.file."${cpuScript}".source = ./cpu_usage;
  hm.home.file."${mediaplayerScript}".source = ./mediaplayer;
  hm.home.file."${statusScript}".text = "";
  hm.home.file."${i3blocksConfigFile}".text = ''
# Global properties
separator=false
separator_block_width=30
# Source the color theme
border_top=0
border_left=0
border_right=0
border_bottom=0
PRIMARY_COLOR=${config.theme.primary}
SECONDARY_COLOR=${config.theme.secondary}
THIRD_COLOR=${config.theme.third}
BACKGROUND_COLOR=${config.theme.background}
FOREGROUND_COLOR=${config.theme.foreground}
markup=pango

[mediaplayer]
instance=spotify
interval=5
signal=10
command=perl ${mediaplayerScript}


[status_script]
interval=10
command=${python-zmq}/bin/python ${statusScript}

[cpu_usage]
interval=3
LABEL=
min_width=X 2000%
T_WARN=50
T_CRIT=80
DECIMALS=0
align=left
command=bash ${cpuScript}

[memory]
LABEL=
interval=30
command=bash ${memoryScript}

[volume-pulseaudio]
min_width=X muted
interval=once
signal=1
align=center
command=bash ${audioScript}

[date]
interval=1
min_width=XXXX-XX-XX X  XX:XX:XX
align=center
command=bash ${dateScript}

'';
}
