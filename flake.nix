{
  description = "My nix config";


  outputs = { self, nixpkgs, home-manager, ... }@inputs:

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
    wm = "hyprland";
    wallpaper = ./wallpapers/kitan_6372.jpg; # TODO: Would wish to go outside of scope if possible here

    privateSystem = "${inputs.private}/system";
    privateHome = "${inputs.private}/home";

    # Out of the colors generated from pywal, which one should be used to what?
    primary = 9;
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
        modules = [ ./nixos/configuration.nix privateSystem ];
        specialArgs = { inherit username wm inputs; };
      };
    };

    # The home configuration
    homeConfigurations = {
      ${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
	  ./home.nix
	  inputs.nur.nixosModules.nur
          privateHome
	];
        extraSpecialArgs = { inherit username name hostname email dotfilesDir term wallpaper theme wm inputs; };
      };
    };
  };


  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
    rust-overlay.url = "github:oxalica/rust-overlay";
    nur.url = "github:nix-community/NUR";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    split-monitor-workspaces = {
      url = "github:Duckonaut/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland";
    };

    # I hate this workaround
    # --override-input private "./path/to/private/folder"
    private.url = "path:./hack";
  };
}
