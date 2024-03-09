{ pkgs, pconf, lanzaboote, nixos-conf-editor, nix-software-center, ... }: {
  imports = [
    lanzaboote.nixosModules.lanzaboote
    ./noclutter.nix
    ./sound.nix
    ./desktop.nix
    ./locale.dk.nix
    ./secureboot.nix
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
    nixos-conf-editor.packages.${system}.nixos-conf-editor
    nix-software-center.packages.${system}.nix-software-center
  ];
  # Auto unlock:
  boot.initrd.systemd.enable = true;
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.plymouth.enable = true;
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    extra-substituters = [
      https://nix-community.cachix.org
    ];
    extra-trusted-public-keys = [
      nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=
    ];
  };
}
