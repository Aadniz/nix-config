{ config, lib, pkgs, ... }:

{
  home.file.".config/pinnacle/metaconfig.toml".source = ./metaconfig.toml;
  home.file.".config/pinnacle/Cargo.toml".source = ./Cargo.toml;

  # Nesessary rust code
  home.file.".config/pinnacle/src".source = ./src;
}
