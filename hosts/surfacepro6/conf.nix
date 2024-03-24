{ config, pkgs, pconf, nixos-hardware, ... }: let
  libcamera_surface = fetchGit {
    name = "libcamera-surface-0.2.0";
    url = "https://github.com/damianoognissanti/libcamera-surface/";
    rev = "7268e5ed4389d8b2390321dd4f47da200bd75fde";
  };
in {
  imports = [
    ./hw.nix
    nixos-hardware.nixosModules.microsoft-surface-pro-intel
    "${libcamera_surface}/libcamera.nix"
    ../../modules/conf.nix
  ];
  #
  networking.hostName = "${pconf.user}-surfacepro"; # Define your hostname.
  # Swap
  swapDevices = [ { device = "/var/swapfile"; size = 10*1024; } ];
  boot.resumeDevice = "/dev/dm-0";  # the unlocked drive mapping
  boot.kernelParams = [
    "resume_offset=11080487"  # for hibernate resume
  ];
  # Camera dependencies
  programs.bash.shellAliases = {
    startcamera = "gst-launch-1.0 libcamerasrc camera-name='\\\\_SB_.PCI0.I2C2.CAMF' ! videoconvert ! v4l2sink device=/dev/video0";
  };
  environment.systemPackages = with pkgs; [
    ffmpeg
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    v4l-utils
  ];
  boot.kernelModules = [
    "v4l2loopback"
  ];
  boot.kernel.sysctl = { "vm.swappiness" = 10; };
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback.out
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
  '';
  # less overheating
  services.thermald.enable = true;
  #
  system.stateVersion = "23.11";  # Do not change
}
