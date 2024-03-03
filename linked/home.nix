{ config, pkgs, ... }:
let
  pconf = import ../common/pconf.nix.secret;
in {
  home.packages = with pkgs; [
    authy
    bitwarden
    brave
    git-crypt
    gnomeExtensions.bing-wallpaper-changer
    gnomeExtensions.dash-to-panel
    gnomeExtensions.touch-x
    qbittorrent
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
