{
  description = "Blah flake";


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
    wallpaper = ./wallpapers/kitan_5980_upscaled.jpg; # TODO: Would wish to go outside of scope if possible here

    # Out of the colors generated from pywal, which one should be used to what?
    primary = 9;
    secondary = 10;
    third = 14;
    foreground = 15;
    background = 0;


    # create patched nixpkgs
    nixpkgs-patched = (import nixpkgs { inherit system; }).applyPatches {
      name = "nixpkgs-patched";
      src = nixpkgs;
      patches = [
        ./patches/emacs-no-version-check.patch
        ./patches/nixos-nixpkgs-268027.patch
      ];
    };

    # configure pkgs
    #pkgs = nixpkgs.legacyPackages.${system};
    pkgs = import nixpkgs-patched {
      inherit system;
      config = { allowUnfree = true;
                 allowUnfreePredicate = (_: true); };
      # overlays = [ rust-overlay.overlays.default ];
    };

    # Colors are generated automatically from the wallpaper
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
    #wallpaper = theme.wallpaper;#"~/Pictures/kitan_5980.jpg";

    # configure lib
    lib = nixpkgs.lib;
    in {
    nixosConfigurations = {
      nix = lib.nixosSystem {
        inherit system;
        modules = [ ./nixos/configuration.nix ];
        specialArgs = {
          # pass config variables from above
          inherit username;
        };
      };
    };
    homeConfigurations = {
      ${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
        extraSpecialArgs = {
          # pass config variables from above
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
    nix-doom-emacs.url = "github:librephoenix/nix-doom-emacs?ref=pgtk-patch";
    stylix.url = "github:danth/stylix";
    rust-overlay.url = "github:oxalica/rust-overlay";
    #nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.2.0";
    eaf = {
      url = "github:emacs-eaf/emacs-application-framework";
      flake = false;
    };
    eaf-browser = {
      url = "github:emacs-eaf/eaf-browser";
      flake = false;
    };
    org-nursery = {
      url = "github:chrisbarrett/nursery";
      flake = false;
    };
    org-yaap = {
      url = "gitlab:tygrdev/org-yaap";
      flake = false;
    };
    org-side-tree = {
      url = "github:localauthor/org-side-tree";
      flake = false;
    };
    org-timeblock = {
      url = "github:ichernyshovvv/org-timeblock";
      flake = false;
    };
    phscroll = {
      url = "github:misohena/phscroll";
      flake = false;
    };
    blocklist-hosts = {
      url = "github:StevenBlack/hosts";
      flake = false;
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      flake = false;
    };
  };
}
