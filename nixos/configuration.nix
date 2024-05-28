# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, username, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./app
      ./bluetooth
      ./hardware
      ./hardware-configuration.nix
      ./misc
      ./networking
      ./nix
      ./security/sshd.nix
      ./shell
      ./wm
    ];

  # Bootloader.
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 15;
    editor = false;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  # Set your time zone.
  time.timeZone = "Europe/Oslo";

  # Supposedly better for the SSD.
  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowInsecure = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "no";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "no";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.root.initialHashedPassword = "$6$m28ZHJp5bx7rIyJs$snUC6gI8q8XSiK/9EGnzDyuMTnMpKDCLjczHjbwZ23.QRTWtnzrmUTTz8O7eqgVsCJtWksFxjieCSFzqx8zwU.";
  users.users.${username} = {
    isNormalUser = true;
    home = "/home/${username}";
    extraGroups = [ "wheel" "networkmanager" "video" "wireshark" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
      zsh
    ];
    initialHashedPassword = "$6$m28ZHJp5bx7rIyJs$snUC6gI8q8XSiK/9EGnzDyuMTnMpKDCLjczHjbwZ23.QRTWtnzrmUTTz8O7eqgVsCJtWksFxjieCSFzqx8zwU.";
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];

    # Deduplicate and optimize nix store
    auto-optimise-store = true;
  };
}
