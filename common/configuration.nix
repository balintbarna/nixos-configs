{ config, pkgs, ... }:
let
  pconf = import ../common/pconf.nix.secret;
in {
  imports = [
    ./noclutter.nix
    ./sound.nix
    ./locale.dk.nix
    # ./secureboot.nix
    # ./nixosgui.nix
    ./binaries.nix
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
    fragments  # torrent
    home-manager  # declarative home
  ];
  #
  programs.steam.enable = true;
  #
  services = {
    flatpak.enable = true;
    openssh.enable = true;
    printing.enable = true;
    xserver = {
      enable = true;
      layout = "dk";
      xkbVariant = "";
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
  # Xbox controller driver
  hardware.xone.enable = true;  # xbox controller dongle
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
