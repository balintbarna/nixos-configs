{ config, lib, pkgs, modulesPath, ... }: {
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];
  #
  boot.initrd.availableKernelModules = [ "xhci_pci" "virtio_pci" "virtio_scsi" "usbhid" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];
  #
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/bf727921-9705-4a8c-836d-78093b24e355";
    fsType = "btrfs";
  };
  #
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/7B27-7287";
    fsType = "vfat";
  };
  #
  swapDevices = [ ];
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
