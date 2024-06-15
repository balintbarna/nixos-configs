{ config, lib, pkgs, modulesPath, ... }: {
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/b6908445-3002-46cb-b728-4dd5901f34b2";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

  boot.initrd.luks.devices."luks-dde82413-28b7-4632-8041-0fbf2cc965ee".device = "/dev/disk/by-uuid/dde82413-28b7-4632-8041-0fbf2cc965ee";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/5030-81AE";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
