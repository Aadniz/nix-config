{ config, lib, pkgs, ... }:
let
  repo = "borg-backup:/raid/backup/borg/${config.hostname}";
  passLocation = "/home/${config.username}/Documents/psswds/borg_password.tyx";
  rshCommand = "ssh -i /home/${config.username}/.ssh/borg";
in
{
  imports = [
    ./apps/detyx.nix
  ];

  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "borg" /* bash */ ''
    BORG_REPO="${repo}" \
    BORG_RSH="${rshCommand}" \
    BORG_PASSCOMMAND="${config.sops.secrets."detyx".path} -j ${passLocation}" \
    ${pkgs.borgbackup}/bin/borg "$@"
    '')
  ];

  services.borgbackup.jobs.data = {
    inherit repo;
    environment = {
      BORG_RSH = rshCommand;
      BORG_RELOCATED_REPO_ACCESS_IS_OK = "1";
    };
    user = config.username;
    paths = [
      "/home/${config.username}"
    ];
    exclude = [
      "/home/${config.username}/Games"
      "/home/${config.username}/.thunderbird"
      "/home/${config.username}/.rustup"
      "/home/${config.username}/.npm"
      "/home/${config.username}/.mozilla"
      "/home/${config.username}/.local"
      "/home/${config.username}/.config/discordcanary"
      "/home/${config.username}/.config/discord"
      "/home/${config.username}/.config/Element"
      "/home/${config.username}/.config/**/*Cache"
      "/home/${config.username}/.cargo"
      "*/vendor"
      "*/tmp"
      "*/target"
      "*/node_modules"
      "*/_?build"
      "*/.venv"
      "*/.snapshots"
      "*/.git"
      "*/.cache"
      "*/.Trash-*"
    ];
    startAt = "daily";
    persistentTimer = true;
    prune.keep = {
      daily = 7;
      weekly = 6;
      monthly = 6;
      yearly = 2;
    };
    encryption.mode = "repokey-blake2";
    encryption.passCommand = "${config.sops.secrets."detyx".path} -j ${passLocation}";
    compression = "lzma,5";
    extraArgs = "--info";
    extraCreateArgs = "--stats --list --filter=ACME";
    #extraCreateArgs = "--verbose --stats --list --info --exclude-if-present .nobackup --syslog-verbosity 0 prune create";
    preHook = ''
      set -x
    '';
    postCreate = ''
      echo done :3
    '';
  };
}
