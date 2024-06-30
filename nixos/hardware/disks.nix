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
  boot.kernelParams = [ "ip=192.168.1.111::192.168.1.1:255.255.255.0:${hostname}:enp38s0:none" ];
  boot.initrd.availableKernelModules = [ "r8169" "igb" ];
  boot.initrd.network = {
    enable = true;
    ssh = {
      enable = true;
      shell = "/bin/cryptsetup-askpass";
      authorizedKeys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCXbtRp0AHkf48ML3xukFzCnQJOeBO9G/mKgKjhHctsMbtlqUk8cwpHp91Jyd3Hz8a84irJnksP59PalTmJrOUk7pob+7WrqUGY3R+nby3U+zUNFTXBy/z3oHeUrgoEXbAPeejS/m2bW7rnq+RARViU0rWM1rw691R8YO+g4S1epxMEEp13/m2OPTTMHwVYlDDwSJ7PApSEYYZ28wRAf9meYP+AO/CtTVlu+vSLpt4k6kEbQYXoNnEEQlbGcrxyNBiPKonpLUXegBX6tlPW79TnrqSp6YZ/mPqeBaPQERQkuVRPejxfaAHUCzdCeax5gwqbQeu06qhR9zWkJVM4xpe5KxYAOyaCePp8RU8qEeqHdBflzSkTouKjdzpCc3gCQU7y4IzXa3fOEwQOZHgsQXdvI0/dH9h71AxD9fLddjAqAcRa/JvJriSHVh1sWnZPxVsC2UDbbL8pfCEbp6wjZqYU7Yc8iHbnnPKyfisOJc9JERkxK327+MyQBf8TiOIm//M= pi@raspberrypi"
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDsmZ7xjnIvROMSCYouj/LzRVjkHooDbKTzfN5KKCGTD/I6xug8vnnR8YYEfDoeMKclHlOjN7k4DwtijHhR2jrDyje6vwHU3YHx38w2etZIStO6g5xb14px79D1+8gxMod6EtfE+N6XuxU2eKaxFnAOrWSLVOA51vfhxDoys+3y00J52asuNJJv0+RmqIMMtPg2S7bOmz4/OSP43NQb9tCnG2wMSi8XB8lyBKjNFzn0MO7thMenrT6A1R92nHJxokHLYEA8C3Qoao0GChAYdZhg6shdb4Wq5pCxVWsme/55WiTgPCBY6lQ5lM/XhlHiGh+m3UQUQKzQCP4BmK0JOY4b root@rProxy"
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDNteqCXydLzQpOG0jejpAJG14PIdgrNMwfTqd+P9hOGoPFodJgnJ84a0uaa1MWK0RSb6go99Do15WwqMiB1qPBWHy6ecpPspGgY4H6qneMDfX2ng2++vM/oW/B3OGoRMf3DcF3qWH4XovAYMbDUueyYL7KxvHw1/cgtLtvjJdXhFS3pG6bwka3dH3YDcAFZ841vsXBlarsG2wYXXcaMc5ca+kz1I9l9XoLwcL2pMbck/Hx0j2CGAgKaTpiJ8MPyy+slnG/aHcGF9z6jWRehotoMxgFWeZEN1YjEr17/iZGxTP+l8LQS+iQeXL02X5n3pu+AMshBBOO3cjgQprMNbMzaAn8vn91gPhKjQ8wlxLY8VIen9HHHc/G3WtLUlGK0izkvSi0xu6sXnYSaoIE9ucKNzVNgaZUiLbxxVph5c1YLtvo/7LcXwc8lRY42LNTyNMQ46gUMFFsC4aQzC6/DngWyQNtvplzv4FRPbwfSAvMgXZ3L2KXg+5k7ekERC1u9pc= chiya@arch"
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
