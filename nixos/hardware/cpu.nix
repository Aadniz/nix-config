{ config, lib, pkgs, ... }:

{
  config = {
    hardware.cpu.amd.updateMicrocode = true;
    # amd virtualization support
    boot.kernelModules = ["kvm-amd"];
    # enable the AMD P-state EPP active driver for CPU scaling
    boot.kernelParams = ["amd_pstate=active"];
  };
}
