{ config, pkgs, ... }:

{
  imports = [
    #./i3blocks/i3blocks.nix
  ];

  # TODO: temporary workaround to mitigate git.st.ht issues
  # https://github.com/nix-community/home-manager/issues/4879#issuecomment-1884851745
  manual = {
    html.enable = false;
    manpages.enable = false;
    json.enable = false;
  };
}
