# Welcome to my nix config

![Wallpaper with neofetch](/docs/screenshots/Screenshot_2024-03-10_08:53:22.png)
![Working with rust in doom emacs](/docs/screenshots/Screenshot_2024-03-10_08:50:44.png)

## Installation

You would first need to get your user up, install home manager and set your username.

``` bash
$ nix-shell -p git
$ git clone https://github.com/Aadniz/nix-config ~/.dotfiles
```

Now that the dotfiles are in the `.dotfiles` folder, edit the username of `flake.nix` to your own.

Then the rest.

``` bash
$ sudo cp /etc/nixos/hardware-configuration.nix ~/.dotfiles/nixos/hardware-configuration.nix
$ sudo mv /etc/nixos/configuration.nix /tmp/configuration.nix.bak
$ sudo ln -s /etc/nixos ~/.dotfiles/nixos
```
Here we combine your hardware-configuration, and then set symbolic link from `/etc/nixos` to `~/.dotfiles/nixos` so that we can edit these files as a user and not as root.

# etc etc to be continued...
