{ config, pkgs, ... }:

{
  # Enable incoming ssh
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "yes";
    };
  };
}
