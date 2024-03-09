{ config, pkgs, my_user, my_name, ... }:
let
  pconf = import ../common/pconf.nix.secret;
in {
  imports = [
    ./binaries.nix
    ./noclutter.nix
    # ./nixosgui.nix
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
    fragments  # torrent
    home-manager  # declarative home
  ];
  #
  programs.steam.enable = true;
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
}
