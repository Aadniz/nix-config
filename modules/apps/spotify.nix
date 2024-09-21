{
  inputs,
  config,
  ...
}: {
  imports = [inputs.nur.nixosModules.nur];
  environment.systemPackages = [config.nur.repos.nltch.spotify-adblock];
}
