# Welcome to my nix config

![Wallpaper with neofetch](/docs/screenshots/Screenshot_2024-09-23_19:34:26.png)
![Starting an application with sway-launcher-desktop](/docs/screenshots/Screenshot_2024-09-23_19:34:46.png)
![Working with nix config in doom emacs](/docs/screenshots/Screenshot_2024-09-23_19:37:46.png)

# Installation

```shell
$ nix-shell -p git nh
$ git clone https://github.com/Aadniz/nix-config ~/.dots
```

## Adding a new machine

When adding a new machine, you need to write a new host.

1. Make a new directory in the [hosts](/hosts) folder
2. Copy the content of `/etc/nixos/`, into the newly created folder 
3. Edit the `configuration.nix` file, adding `settings.nix` as an import as such:

``` nix
  imports =
    [ # Include the results of the hardware scan.
      ./settings.nix
      ./hardware-configuration.nix
    ];
```

4. Create a `settings.nix` file with the required fields, here is a minimal setup:

``` nix
{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ../../options
  ] ++ [  # Extended settings config (relative folder files ./file.nix)

  ] ++ [  # Include the modules you want to have on this host (from the module folder ../../modules/file.nix)
    ../../common
    ../../modules/home-manager.nix
    ../../modules/home.nix
  ] ++ [  # Include all apps you want to use on this host (from the apps in modules folder ../../modules/apps/file.nix)

  ];

  # Don't need any additional config for the apps, just throw them in here
  environment.systemPackages = with pkgs; [
    discord anki
  ];

  username = "user";
  nickname = "User";
  hostname = "laptop";
  flakeDir = "/home/${config.username}/.dots";
  wms = ["sway"];
}
```

5. Choose a hostname, and add a new machine in the [flake.nix](/flake.nix) file as follows:

``` nix
  outputs = { self, nixpkgs, home-manager, ... }@inputs: {

    # Machine1 with hostname "sushi" for example
    nixosConfigurations.sushi = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/sushi/configuration.nix
        home-manager.nixosModules.home-manager
      ];
    };

    # Machine2 with hostname "taco" for example
    nixosConfigurations.taco = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/taco/configuration.nix
        home-manager.nixosModules.home-manager
      ];
    };

  };
```


6. Enter shell `nix-shell -p git nh`, and do the following command to test it:

   ```shell
   FLAKE=~/.dots nh os test --hostname <HOSTNAME> -- --extra-experimental-features nix-command --extra-experimental-features flakes
   ```
   
7. If everything worked, do `FLAKE=~/.dots nh os switch`, then reboot.


## Adding an existing machine

When adding an existing machine, all you need to do is to overwrite the `hardware-configuration.nix` found in `/etc/nixos` with the configuration in the [hosts](/hosts) folder.

Then `nix-shell -p git nh`, entering a shell with git and nh available. Then do the following command to confirm it's working:

```shell
FLAKE=~/.dots nh os test --hostname <HOSTNAME> -- --extra-experimental-features nix-command --extra-experimental-features flakes
```

If it works, then you can apply it with `switch`:

```shell
FLAKE=~/.dots nh os switch --hostname <HOSTNAME> -- --extra-experimental-features nix-command --extra-experimental-features flakes
```

Then reboot.

# Finishing touches

## Tune hardware

The setup may not be the same, and so it might be needed to tune the configs such as the [sway/hardware.nix](/modules/wms/sway/hardware.nix)

## DOOM EMACS

NixOS won't install doom emacs for you, so you have to go to their install instructions for that to be installed: https://github.com/doomemacs/doomemacs?tab=readme-ov-file#install

## If you are me

- You need to clone private status command repo to Documents
- Make the `~/.unison/org-files.prf` configuration
- Need to make sure the appropriate sops are set
- Set up borg backup ([borg.nix](/modules/borg.nix))

*The configuration is not broken because these things are not added. It's structured to accept both.*
