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
  ];
}
