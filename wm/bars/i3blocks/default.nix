{ i3blocksConfigDir, i3blocksConfigFile, theme, ... }:
let
  dateScript = "${i3blocksConfigDir}/date";
  audioScript = "${i3blocksConfigDir}/volume-pulseaudio";
  memoryScript = "${i3blocksConfigDir}/memory";
  cpuScript = "${i3blocksConfigDir}/cpu_usage";
  mediaplayerScript = "${i3blocksConfigDir}/mediaplayer";
in
{

  home.file."${dateScript}" = {
    source = ./date;
  };

  home.file."${audioScript}" = {
    source = ./volume-pulseaudio;
  };

  home.file."${memoryScript}" = {
    source = ./memory;
  };

  home.file."${cpuScript}" = {
    source = ./cpu_usage;
  };

  home.file."${mediaplayerScript}" = {
    source = ./mediaplayer;
  };

  home.file."${i3blocksConfigFile}".text = ''
# Global properties
separator=false
separator_block_width=30
# Source the color theme
border_top=0
border_left=0
border_right=0
border_bottom=0
PRIMARY_COLOR=${theme.primary}
SECONDARY_COLOR=${theme.secondary}
THIRD_COLOR=${theme.third}
BACKGROUND_COLOR=${theme.background}
FOREGROUND_COLOR=${theme.foreground}
markup=pango

[mediaplayer]
instance=spotify
interval=5
signal=10
command=perl ${mediaplayerScript}

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
