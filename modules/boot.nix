{ pkgs, pconf, ... }: {
  imports = [
    ./secureboot.nix
  ];
  boot.initrd.systemd.enable = true;  # For auto unlock
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth.enable = true;
}
