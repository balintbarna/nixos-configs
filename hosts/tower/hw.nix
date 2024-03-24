{ config, lib, pkgs, modulesPath, ... }: {
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/6fddd523-3aac-46a8-aca7-12da5405bd82";
    fsType = "btrfs";
  };
  boot.initrd.luks.devices."luks-025814c8-3dcf-4bd8-b04f-c2abaeb82644".device = "/dev/disk/by-uuid/025814c8-3dcf-4bd8-b04f-c2abaeb82644";
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/0E4B-AA5D";
    fsType = "vfat";
  };
  swapDevices = [ ];
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
