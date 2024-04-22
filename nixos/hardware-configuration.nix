# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.luks.devices."luks-7a6c12af-b050-40fe-ac96-124538dfc122".device = "/dev/disk/by-uuid/7a6c12af-b050-40fe-ac96-124538dfc122";

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/5782e1d1-4145-476b-8d41-097896242b21";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-8b6ff769-e22d-4656-9561-bb4efdb72baf".device = "/dev/disk/by-uuid/8b6ff769-e22d-4656-9561-bb4efdb72baf";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/70F6-725B";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/62f10e93-a230-452e-bcca-6d2bd229e2f9"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp38s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp39s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
