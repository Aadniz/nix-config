{config, ...}: {

  # https://github.com/Scrumplex/flake/blob/main/nixosConfigurations/common/v4l2loopback.nix

  boot.extraModulePackages = [config.boot.kernelPackages.v4l2loopback];
  boot.kernelModules = ["v4l2loopback"];
}
