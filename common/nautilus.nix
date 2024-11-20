{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nautilus
  ];

  hm.dconf.settings."org/gnome/nautilus/preferences" = {
    default-sort-in-reverse-order = true;
    default-sort-order = "mtime";
  };
}
