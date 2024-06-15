{ config, pkgs, pconf, nixos-hardware, ... }: let
  # libcamera_surface = fetchGit {
  #   name = "libcamera-surface-0.2.0";
  #   url = "https://github.com/damianoognissanti/libcamera-surface/";
  #   rev = "7268e5ed4389d8b2390321dd4f47da200bd75fde";
  # };
in {
  imports = [
    ./hw.nix
    # nixos-hardware.nixosModules.microsoft-surface-pro-intel
    # "${libcamera_surface}/libcamera.nix"
    ../../modules/personal.nix
  ];
  #
  networking.hostName = "${pconf.user}-surfacepro"; # Define your hostname.
  # Swap
  swapDevices = [ { device = "/var/swapfile"; size = 10*1024; } ];
  boot.resumeDevice = "/dev/dm-0";  # the unlocked drive mapping
  boot.kernelParams = [
    "resume_offset=11080487"  # for hibernate resume
  ];
  # Aliases
  programs.bash.shellAliases = {
    buttonsreload = "sudo modprobe -r soc_button_array && sudo modprobe soc_button_array";
    # touchreload = "sudo systemctl restart iptsd";
    # camerastart = "gst-launch-1.0 libcamerasrc camera-name='\\\\_SB_.PCI0.I2C2.CAMF' ! videoconvert ! v4l2sink device=/dev/video0";
  };
  # Camera dependencies
  # environment.systemPackages = with pkgs; [
  #   ffmpeg
  #   gst_all_1.gstreamer
  #   gst_all_1.gst-plugins-base
  #   gst_all_1.gst-plugins-good
  #   v4l-utils
  # ];
  # boot.kernelModules = [
  #   "v4l2loopback"
  # ];
  # boot.extraModulePackages = with config.boot.kernelPackages; [
  #   v4l2loopback.out
  # ];
  # boot.extraModprobeConfig = ''
  #   options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
  # '';
  # use disk less
  # boot.kernel.sysctl = { "vm.swappiness" = 10; };
  # less overheating
  # services.thermald.enable = true;
  # Sleep
  # services.upower = {
  #   enable = true;
  #   criticalPowerAction = "Hibernate";
  # };
  # systemd.sleep.extraConfig = ''
  #   HibernateDelaySec=1m
  # '';
  # powerManagement.resumeCommands = ''
  #   modprobe -r soc_button_array && modprobe soc_button_array
  # '';
  # Version at installation
  system.stateVersion = "23.11";
}
