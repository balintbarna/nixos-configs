{ config, pkgs, pconf, nixos-hardware, ... }: {
  imports = [
    ./hw.nix
    nixos-hardware.nixosModules.asus-ally-rc71l
    ../../modules/personal.nix
  ];
  # Gaming
  programs.steam.enable = true;
  hardware.xone.enable = true;  # xbox controller dongle
  hardware.xpadneo.enable = true;  # xbox controller bt
  environment.systemPackages = with pkgs; [
    heroic
  ];
  services.handheld-daemon.enable = true;
  services.handheld-daemon.user = pconf.user;
  # Define your hostname.
  networking.hostName = "${pconf.user}-ally";
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # Version at installation
  system.stateVersion = "24.05";
}
