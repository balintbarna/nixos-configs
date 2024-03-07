{ config, pkgs, ... }: let
  nixos_hardware = fetchGit {
    name = "nixos-hardware-2024-03-03";
    url = "https://github.com/NixOS/nixos-hardware/";
    rev = "59e37017b9ed31dee303dbbd4531c594df95cfbc";
    submodules = true;
  };
  #
  libcamera_surface = fetchGit {
    name = "libcamera-surface-0.2.0";
    url = "https://github.com/damianoognissanti/libcamera-surface/";
    rev = "7268e5ed4389d8b2390321dd4f47da200bd75fde";
    submodules = true;
  };
  #
  pconf = import ../common/pconf.nix.secret;
in {
  imports = [
    /etc/nixos/hardware-configuration.nix
    "${nixos_hardware}/microsoft/surface/surface-pro-intel/"
    "${libcamera_surface}/libcamera.nix"
    ../common/configuration.nix
  ];
  #
  networking.hostName = "${pconf.user}-surfacepro"; # Define your hostname.
  # Configure console keymap
  console.keyMap = "dk-latin1";
  # Swap
  swapDevices = [ { device = "/var/swapfile"; size = 10*1024; } ];
  boot.resumeDevice = "/dev/dm-0";  # the unlocked drive mapping
  boot.kernelParams = [
    "resume_offset=11080487"  # for hibernate resume
    "mem_sleep_default=deep"  # less drain on sleep
  ];
  # Camera dependencies
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
