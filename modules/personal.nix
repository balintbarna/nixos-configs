{ pkgs, pconf, ... }: {
  imports = [
    ./desktop.nix
    ./boot.nix
    # ./binaries.nix
  ];
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${pconf.user} = {
    isNormalUser = true;
    description = pconf.name;
    extraGroups = [ "networkmanager" "wheel" "video" ];
  };
  # Declarative home configuration
  environment.systemPackages = [ pkgs.home-manager ];
  # Nix
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
