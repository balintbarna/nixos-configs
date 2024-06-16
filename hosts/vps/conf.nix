{ pkgs, pconf, ... }: {
  imports = [
    ./hw.nix
    ./net.nix
    ./fresh.nix
    ./services.nix
  ];
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Enable console during boot
  boot.initrd.kernelModules = [ "virtio_gpu" ];
  boot.kernelParams = [ "console=tty" ];
  # Mount storage
  fileSystems."/mnt/box" = {
    device = "${pconf.domain.box}:/home";
    fsType = "fuse.sshfs";
    options = [ "defaults" "_netdev" "port=23" "allow_other" "compression=no" ];
  };
  # Set your time zone.
  time.timeZone = pconf.timezone;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${pconf.user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };
  # Add git - needed for everything
  programs.git.enable = true;
  environment.systemPackages = with pkgs; [
    diskonaut
    git-crypt
    helix
    htop
    sshfs
    tree
  ];
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  # Experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Version at installation
  system.stateVersion = "24.05";
}
