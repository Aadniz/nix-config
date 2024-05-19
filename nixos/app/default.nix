{ config, lib, pkgs, ... }:

{
  imports = [
    ./virtualization
    ./amdgpu-fan
  ];

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    gotop
    btop
    amdgpu_top
    wget
    git
    vlc
    firefox
    pywal
    konsole
  ];
}
