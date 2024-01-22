{ config, lib, pkgs, username, ... }:
let
  archDisk = {
    mountLocation = "/mnt/arch";
    device = "/dev/disk/by-uuid/b258429b-2584-4825-9d8f-c2c9043fb1cf";
    fsType = "ext4";
    mountDirs = [
      "Pictures" "Music" "Documents" "Videos" "Webservers" "Games"
      "AndroidStudioProjects" "Blender" "CLionProjects" "DataGripProjects"
      "GolandProjects" "IdeaProjects" "NetBeansProjects" "PycharmProjects"
      "RiderProjects" "RustroverProjects" "WebstormProjects" "Unity"
    ];
  };
in
{
  # Old Arch
  boot.initrd.luks.devices."dm_crypt" = {
    device = "/dev/disk/by-uuid/1bd7c6a2-7c96-4395-b14a-bbf7d8e5577e";
    preLVM = true;
  };

  # BigData
  boot.initrd.luks.devices."dm_crypt-2" = {
    device = "/dev/disk/by-uuid/15b3a767-27e2-4f23-8146-01855490b3a2";
    preLVM = true;
  };

  fileSystems = {
    "${archDisk.mountLocation}" = {
      device = archDisk.device;
      fsType = archDisk.fsType;
    };

    # The chonky 4 TB disk
    "/mnt/bigdata" = {
      device = "/dev/disk/by-uuid/4367cd83-4a0c-460e-add8-82a3a5fb3bb1";
      fsType = "ext4";
    };
    "/home/${username}/Downloads" = {
      device = "/mnt/bigdata/Downloads";
      options = [ "bind" ];
    };

    # The very very old Windows filesystem
    "/mnt/windows/GAMES" = {
      device = "/dev/disk/by-uuid/CA72F14B72F13D2F";
      fsType = "ntfs";
    };
    "/mnt/windows/EDIT" = {
      device = "/dev/disk/by-uuid/34DEF1B3DEF16E0C";
      fsType = "ntfs";
    };
  }

  # This maps all /mnt/arch/{Pictures, Music, Documents, ...} to ~/{Pictures, Music, Documents, ...}
  // builtins.listToAttrs (map (dir: {
    name = "/home/${username}/${dir}";
    value = {
      device = "${archDisk.mountLocation}/home/chiya/${dir}";
      options = [ "bind" ];
    };
  }) archDisk.mountDirs);
}
