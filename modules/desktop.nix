{
  imports = [
    ./noclutter.nix
    ./sound.nix
    ./locale.dk.nix
  ];
  networking.networkmanager.enable = true;
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
  services = {
    flatpak.enable = true;
    openssh.enable = true;
    printing.enable = true;
    xserver = {
      enable = true;
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
      xkb.layout = "dk,hu";
    };
  };
  console.useXkbConfig = true;
}
