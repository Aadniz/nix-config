{ config, lib, pkgs, ... }:

{

  options = {

    # Networking options
    network = lib.mkOption {
      type = lib.types.submodule {
        options = {
          interface = lib.mkOption {
            type = lib.types.str;
            description = "Network interface, example eth0";
          };
          address = lib.mkOption {
            type = lib.types.str;
            description = "Network address, example 192.168.1.123";
          };
          gateway = lib.mkOption {
            type = lib.types.str;
            description = "Gateway, example 192.168.1.1";
          };
          dns = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            description = "DNS, example [ \"8.8.8.8\" \"1.1.1.1\" ]";
          };
          extraHosts = lib.mkOption {
            type = lib.types.attrsOf lib.types.str;
            description = "Extra hosts /etc/hosts, example { \"192.168.1.140\" = \"my.host.com\" }";
          };
        };
      };
      description = "Network settings";
    };

    # Disks options
    extraDisks = lib.mkOption {
      type = lib.types.listOf (lib.types.submodule {
        options = {
          luksName = lib.mkOption {
            type = lib.types.str;
            description = "The name used when opening the LUKS device";
          };
          mountLocation = lib.mkOption {
            type = lib.types.str;
            description = "The location where the disk will be mounted";
          };
          device = lib.mkOption {
            type = lib.types.str;
            description = "The LUKS device";
          };
          lvm = lib.mkOption {
            type = lib.types.str;
            description = "The LVM volume";
          };
        };
      });
      default = [ ];
      description = "List of extra disks";
    };

    remoteDecryption = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable or disable remote decryption";
    };
  };
}
