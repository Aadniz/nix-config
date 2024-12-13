{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.nur.modules.nixos.default];
  environment.systemPackages = [pkgs.nur.repos.nltch.spotify-adblock];
}
