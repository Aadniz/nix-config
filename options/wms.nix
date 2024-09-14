{ config, lib, pkgs, ... }:

{
  options = {
    wms = lib.mkOption {
      type = lib.types.listOf lib.types.string;
      default = [ ];
      description = "What wms to have installed";
    };
  };

}
