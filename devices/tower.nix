{ config, lib, pkgs, ... }:
let
  pconf = import ../common/pconf.nix.secret;
in {
  imports = [
    ../common/configuration.nix
  ];
  #
  networking.hostName = "${pconf.user}-tower"; # Define your hostname.
  # Select internationalisation properties.
  i18n.defaultLocale = "en_DK.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_DK.UTF-8";
    LC_IDENTIFICATION = "en_DK.UTF-8";
    LC_MEASUREMENT = "en_DK.UTF-8";
    LC_MONETARY = "en_DK.UTF-8";
    LC_NAME = "en_DK.UTF-8";
    LC_NUMERIC = "en_DK.UTF-8";
    LC_PAPER = "en_DK.UTF-8";
    LC_TELEPHONE = "en_DK.UTF-8";
    LC_TIME = "en_DK.UTF-8";
  };
  # Swap - create with `btrfs filesystem mkswapfile --size <size>g /var/swapfile`
  swapDevices = [ { device = "/var/swapfile"; size = 18*1024; } ];
  boot.resumeDevice = "/dev/dm-0";  # the unlocked drive mapping
  boot.kernelParams = [
    # filefrag -v /var/swapfile  # not btrfs
    # btrfs inspect-internal map-swapfile -r /var/swapfile  # btrfs
    "resume_offset=10134041"
  ];
  # Configure console keymap
  console.keyMap = "dk-latin1";
  # nvidia: Make sure opengl is enabled
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  hardware.nvidia = {
    # Modesetting is needed for most wayland compositors
    modesetting.enable = true;
    # Do NOT use the open source version of the kernel module
    open = false;
  };
  # NVIDIA drivers are unfree.
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "nvidia-x11"
    ];
  # nvidia
  services.xserver.displayManager.gdm.wayland = false;
  services.xserver.videoDrivers = ["nvidia"];
  #
  system.stateVersion = "23.11";  # Do not change
}
