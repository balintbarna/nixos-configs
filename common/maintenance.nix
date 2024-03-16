{ ... }: {
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L" # print build logs
    ];
    dates = "weekly";
  };  # https://nixos.wiki/wiki/Automatic_system_upgrades
  #
  nix.settings.auto-optimise-store = true;
  #
  nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };
  #
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };  # https://nixos.wiki/wiki/Storage_optimization
}
