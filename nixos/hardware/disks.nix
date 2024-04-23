{ config, lib, pkgs, username, hostname, ... }:
let
  bigDisk = {
    mountLocation = "/mnt/bigdata";
    bindDir = "/home/${username}";
    device = "/dev/disk/by-uuid/4367cd83-4a0c-460e-add8-82a3a5fb3bb1";
    fsType = "ext4";
    mountDirs = [
      "Music" "Videos" "Games" "Blender" "Unity" "Downloads"
    ];
  };
  disk500 = {
    mountLocation = "/mnt/500";
    bindDir = "/home/${username}";
    device = "/dev/disk/by-uuid/946fedd9-e213-4299-b2f9-8ed2116159e1";
    fsType = "ext4";
    mountDirs = [
      "Jetbrains"
    ];
  };

  # Function to generate filesystem configuration for a disk
  genFsConfig = disk: {
    "${disk.mountLocation}" = {
      device = disk.device;
      fsType = disk.fsType;
    };
  } // builtins.listToAttrs (map (dir: {
    name = "${disk.bindDir}/${dir}";
    value = {
      device = "${disk.mountLocation}/${dir}";
      options = [ "bind" ];
    };
  }) disk.mountDirs);
in
{
  # Remote decryption (for practicing nixos)
  boot.kernelParams = [ "ip=192.168.111.111::192.168.111.1:255.255.255.0:${hostname}:enp38s0:none" ];
  boot.initrd.availableKernelModules = [ "r8169" "igb" ];
  boot.initrd.network = {
    enable = true;
    ssh = {
      enable = true;
      shell = "/bin/cryptsetup-askpass";
      authorizedKeys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCXbtRp0AHkf48ML3xukFzCnQJOeBO9G/mKgKjhHctsMbtlqUk8cwpHp91Jyd3Hz8a84irJnksP59PalTmJrOUk7pob+7WrqUGY3R+nby3U+zUNFTXBy/z3oHeUrgoEXbAPeejS/m2bW7rnq+RARViU0rWM1rw691R8YO+g4S1epxMEEp13/m2OPTTMHwVYlDDwSJ7PApSEYYZ28wRAf9meYP+AO/CtTVlu+vSLpt4k6kEbQYXoNnEEQlbGcrxyNBiPKonpLUXegBX6tlPW79TnrqSp6YZ/mPqeBaPQERQkuVRPejxfaAHUCzdCeax5gwqbQeu06qhR9zWkJVM4xpe5KxYAOyaCePp8RU8qEeqHdBflzSkTouKjdzpCc3gCQU7y4IzXa3fOEwQOZHgsQXdvI0/dH9h71AxD9fLddjAqAcRa/JvJriSHVh1sWnZPxVsC2UDbbL8pfCEbp6wjZqYU7Yc8iHbnnPKyfisOJc9JERkxK327+MyQBf8TiOIm//M= pi@raspberrypi"
      ];
      hostKeys = ["/etc/secrets/initrd/id_ed25519"];
    };
  };

  # 500 GB disk
  boot.initrd.luks.devices."dm_crypt" = {
    device = "/dev/disk/by-uuid/db6b7f07-53d6-4602-87ae-2b8e1c405ea7";
  };

  # BigData
  boot.initrd.luks.devices."dm_crypt-2" = {
    device = "/dev/disk/by-uuid/15b3a767-27e2-4f23-8146-01855490b3a2";
    preLVM = true;
  };

  fileSystems = {
    # The very very old Windows filesystem
    "/mnt/windows/GAMES" = {
      device = "/dev/disk/by-uuid/CA72F14B72F13D2F";
      fsType = "ntfs";
    };
    "/mnt/windows/EDIT" = {
      device = "/dev/disk/by-uuid/34DEF1B3DEF16E0C";
      fsType = "ntfs";
    };
  } // genFsConfig bigDisk // genFsConfig disk500;

  # No need to preserve whats in /tmp
  boot.tmp.cleanOnBoot = true;
}
