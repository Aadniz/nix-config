{
  description = "Blah flake";


  outputs = { self, nixpkgs, home-manager, nur, aadniz, ... }@inputs:

  let
    # ---- SYSTEM SETTINGS ---- #
    system = "x86_64-linux"; # system arch
    hostname = "nix"; # hostname
    timezone = "Europe/Oslo"; # select timezone
    locale = "en_US.UTF-8"; # select locale

    # ----- USER SETTINGS ----- #
    username = "chiya"; # username
    name = "Chiya"; # name/identifier
    email = "pus@null.net"; # email (used for certain configurations)
    dotfilesDir = "~/.dotfiles"; # absolute path of the local repo
    term = "kitty"; # Default terminal command;
    wallpaper = ./wallpapers/kitan_5980_upscaled.jpg; # TODO: Would wish to go outside of scope if possible here

    # ----- ARE YOU ME OR NOT -----
    hasPrivateAccess = (let result = builtins.tryEval (import "${aadniz}"); in result.success);


    # Out of the colors generated from pywal, which one should be used to what?
    primary = 13;
    secondary = 14;
    third = 10;
    foreground = 15;
    background = 0;


    # configure pkgs
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
        allowUnfreePredicate = (_: true);
      };
    };

    # Colors are generated automatically from the wallpaper
    # TODO: hopefully one day I can make this look prettier
    theme = import ./theme {
      inherit primary;
      inherit secondary;
      inherit third;
      inherit foreground;
      inherit background;
      inherit username;
      inherit wallpaper;
      inherit pkgs;
    };


    lib = nixpkgs.lib;
  in {

    # The system configuration
    nixosConfigurations = {
      nix = lib.nixosSystem {
        inherit system;
        modules = [ ./nixos/configuration.nix ];
        specialArgs = {
          inherit username;
        };
      };
    };

    # The home configuration
    homeConfigurations = {
      ${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules =
          let
            baseModules = [ ./home.nix nur.nixosModules.nur ];
            aadnizModule = if hasPrivateAccess then [(import "${aadniz}/default.nix")] else [];
          in
            baseModules ++ aadnizModule;
        extraSpecialArgs = {
          inherit username;
          inherit name;
          inherit hostname;
          inherit email;
          inherit dotfilesDir;
          inherit term;
          inherit wallpaper;
          inherit theme;
        };
      };
    };
  };


  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
    rust-overlay.url = "github:oxalica/rust-overlay";
    nur.url = github:nix-community/NUR;
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      flake = false;
    };
    aadniz = {
      url = "git+ssh://github.com/Aadniz/nix-config-bridge.git";
      flake = false;
    };
  };
}
