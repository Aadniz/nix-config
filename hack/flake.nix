{
  description = "Dummy thing to make it compile";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, nixpkgs, home-manager }: {

    packages.x86_64-linux = {
      default = import ./default.nix {
        system = "x86_64-linux";
        inherit (nixpkgs) pkgs;
      };
    };

    homeManagerModules.default = import ./home.nix self;
  };
}
