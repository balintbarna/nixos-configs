{ pkgs, lib, pconf, ... }: {
  imports = [
    ./hw.nix
    ../../modules/personal.nix
  ];
  # Gaming
  programs.steam.enable = true;
  hardware.xone.enable = true;  # xbox controller dongle
  environment.systemPackages = with pkgs; [
    heroic
    itch
  ];
  #
  networking.hostName = "${pconf.user}-tower"; # Define your hostname.
  # Swap - create with `btrfs filesystem mkswapfile --size <size>g /var/swapfile`
  swapDevices = [ { device = "/var/swapfile"; size = 18*1024; } ];
  boot.resumeDevice = "/dev/dm-0";  # the unlocked drive mapping
  boot.kernelParams = [
    # filefrag -v /var/swapfile  # not btrfs
    # btrfs inspect-internal map-swapfile -r /var/swapfile  # btrfs
    "resume_offset=10134041"
  ];
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
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  #
  system.stateVersion = "23.11";  # Do not change
}
