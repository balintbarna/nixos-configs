# Plymouth option will hide boot text, make sure to enroll device for auto decrypt first
# Find device - `blkid | grep crypto`
# Enroll - `systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+7 <luks2 partition>`
#
{ config, pkgs, my_user, my_name, ... }:
let
  pconf = import ../common/pconf.nix.secret;
in {
  imports = [
    # ./secureboot.nix
  ];
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${pconf.user} = {
    isNormalUser = true;
    description = pconf.name;
    extraGroups = [ "networkmanager" "wheel" "video" ];
  };
  #
  environment.systemPackages = with pkgs; [
    evolution  # to set up mail accounts
    fragments
    home-manager  # declarative home
  ];
  #
  programs.steam.enable = true;
  #
  services = {
    flatpak.enable = true;
    openssh.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    printing.enable = true;
    xserver = {
      enable = true;
      layout = "dk";
      xkbVariant = "";
      excludePackages = [ pkgs.xterm ];
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
    };
  };
  # Auto unlock:
  boot.initrd.systemd.enable = true;
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.plymouth.enable = true;
  # Enable networking
  networking.networkmanager.enable = true;
  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  hardware.xone.enable = true;  # xbox controller dongle
  security.rtkit.enable = true;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  #
  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    gnome-maps
    simple-scan
    yelp
  ]);
  #
  documentation.nixos.enable = false;
}
