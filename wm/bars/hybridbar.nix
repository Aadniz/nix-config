{config, pkgs, lib, ...}:

# This does not work, too many errors, can't figure out

let
  settings = {
    hybrid = {
      namespace = "hybrid-bar";
      r = 10;
      g = 10;
      b = 10;
      a = 1.0;
    };
    "left-label_username" = {
      text = "user: ";
      command = "whoami";
      tooltip = "And here's your kernel: ";
      tooltip_command = "uname -r";
      update_rate = 50000;
    };
    "centered-label_centerdummy" = {
      text = "Example Config - Create/Edit yours at ~/.config/HybridBar/config.json";
      tooltip = "An example of a centered label";
    };
    "right-label_rightdummy" = {
      text = "dummy right aligned label";
      tooltip = "An example of a right-aligned label";
    };
  };
  css = ''
    /* Label Color. Config default is white. */
    label {
        color:          white;
    }

    /* Button Configuration */
    button {
        font-weight:    normal;
        border:         none;
        box-shadow:     none;
        margin-bottom: -8px;
        margin-top:    -8px;
        padding-right:  0;
        padding-left:   0;
    }
  '';
in
{
  home.packages = with pkgs; [
    (config.nur.repos."minion3665".hybridbar.overrideAttrs (oldAttrs: {
      postInstall = ''
       # wrapProgram $out/bin/hybridbar \
       #   --prefix XDG_DATA_DIRS : /nix/store/crqlkqcgd6y9pvxl8ivmvirldh5j29rl-home-manager-path/share/gsettings-schemas/Hybridbar-1.0.0
      '';
    }))
  ];

  home.file.".config/HybridBar/config.json".text = builtins.toJSON settings;
  home.file.".config/HybridBar/style.css".text = css;
}
