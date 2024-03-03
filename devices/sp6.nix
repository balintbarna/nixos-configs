# import this file in /etc/nixos/configuration.nix
{ config, ... }:
let
  nixos_hardware = builtins.fetchGit {
    name = "nixos-hardware-2024-03-03";
    url = "https://github.com/NixOS/nixos-hardware/";
    rev = "59e37017b9ed31dee303dbbd4531c594df95cfbc";
    submodules = true;
  };
  pconf = import ../common/pconf.nix.secret;
in {
  imports = [
    "${nixos_hardware}/microsoft/surface/surface-pro-intel"
    ../common/configuration.nix
  ];
  #
  powerManagement.cpuFreqGovernor = "powersave";
  #
  networking.hostName = "${pconf.user}-surfacepro"; # Define your hostname.
  # Select internationalisation properties.
  i18n.defaultLocale = "en_DK.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "da_DK.UTF-8";
    LC_IDENTIFICATION = "da_DK.UTF-8";
    LC_MEASUREMENT = "da_DK.UTF-8";
    LC_MONETARY = "da_DK.UTF-8";
    LC_NAME = "da_DK.UTF-8";
    LC_NUMERIC = "da_DK.UTF-8";
    LC_PAPER = "da_DK.UTF-8";
    LC_TELEPHONE = "da_DK.UTF-8";
    LC_TIME = "da_DK.UTF-8";
  };
  # Configure console keymap
  console.keyMap = "dk-latin1";
  # Swap - create with `btrfs filesystem mkswapfile --size <size>g /var/swapfile`
  swapDevices = [ { device = "/var/swapfile"; size = 10*1024; } ];
  boot.resumeDevice = "/dev/dm-0";  # the unlocked drive mapping
  boot.kernelParams = [
    # filefrag -v /var/swapfile  # not btrfs
    # btrfs inspect-internal map-swapfile -r /var/swapfile  # btrfs
    "resume_offset=11080487"
  ];
  #
  system.stateVersion = "23.11";  # Do not change
}
