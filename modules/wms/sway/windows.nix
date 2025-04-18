{
  border = 2;
  titlebar = false;
  commands = [
    {
      criteria = {
        #title = "(?:Open|Save) (?:File|Folder|As)";
        title = "(?:Open|Save) (?:\w+ )?(?:File|Folder|As)";
      };
      command = "floating enable, resize set width 800 height 600";
    }
    {
      criteria = {
        instance = "copilot.microsoft.com";
      };
      command = "move scratchpad, resize set 1200 px 1300 px, border pixel, scratchpad show";
    }
    {
      criteria = {
        instance = "x.com__i_grok";
      };
      command = "move scratchpad, resize set 1200 px 1300 px, border pixel, scratchpad show";
    }
    {
      criteria = {
        app_id = "anki";
      };
      command = "floating enable, resize set 1400 px 1000 px";
    }
    {
      criteria = {
        app_id="floatingKitty";
      };
      command = "floating enable, resize set 1300 px 800 px, border pixel";
    }
    {
      criteria = {
        app_id="kitty-sway-launcher-desktop";
      };
      command = "floating enable, resize set 1300 px 800 px, border pixel";
    }
    {
      criteria = {
        app_id="mpv";
      };
      command = "floating enable, border pixel";
    }
    {
      criteria = {
        class="feh";
      };
      command = "floating enable, border pixel";
    }
    {
      criteria = {
        app_id = "nemo";
      };
      command = "move scratchpad, resize set 1300 px 800 px, border pixel, scratchpad show";
    }
    {
      criteria.app_id = "kitty";
      command = "border pixel";
    }
    {
      criteria.app_id = "discord";
      command = "border pixel";
    }
    {
      criteria.app_id = "Element";
      command = "border pixel";
    }
  ];
}
