{ pkgs, pconf, ... }: {
  imports = [
    ./online-accounts.nix
  ];
  home.packages = with pkgs; [
    authy
    bitwarden
    brave
    easyeffects
    element-desktop
    gimp
    git-crypt
    gnomeExtensions.appindicator
    gnomeExtensions.bing-wallpaper-changer
    gnomeExtensions.dash-to-panel
    gnomeExtensions.touch-x
    spotify
    stremio
    terminator
    vscode
  ];
  #
  programs.git = {
    enable = true;
    extraConfig.user = {
      name = pconf.name;
      email = pconf.mail;
    };
  };
  #
  dconf.settings."org/gnome/desktop/wm/preferences".button-layout = ":minimize,close";
  #
  nixpkgs.config.allowUnfree = true;
  #
  home.username = pconf.user;
  home.homeDirectory = pconf.home;
  #
  home.enableNixpkgsReleaseCheck = false;
  home.stateVersion = "23.11";
}
