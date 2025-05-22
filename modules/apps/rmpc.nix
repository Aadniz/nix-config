{ config, lib, pkgs, ... }:

{
  hm.programs.rmpc = {
    enable = true;

    config = ''
      (
          address: "127.0.0.1:6600",
          password: None,
          theme: None,
          cache_dir: None,
          on_song_change: None,
          volume_step: 5,
          max_fps: 60,
          scrolloff: 0,
          wrap_navigation: false,
          enable_mouse: true,
          enable_config_hot_reload: true,
          select_current_song_on_change: false,
          browser_song_sort: [Disc, Track, Artist, Title],
      )
    '';
  };
}
