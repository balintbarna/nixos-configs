{
  networking.networkmanager.enable = true;
  services = {
    flatpak.enable = true;
    openssh.enable = true;
    printing.enable = true;
    xserver = {
      enable = true;
      layout = "dk,hu";
      xkbVariant = "";
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
    };
  };
  console.useXkbConfig = true;
}