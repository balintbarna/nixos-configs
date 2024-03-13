{ pkgs, pconf, ... }: {
  imports = [
    ./online-accounts.nix
  ];
  home.packages = with pkgs; [
    authy  # MFA codes
    bitwarden  # passwords
    brave  # browser
    easyeffects  # bass boost and more
    element-desktop  # matrix chat
    evolution  # to set up mail accounts
    gimp
    git-crypt  # secrets in git repos
    gnomeExtensions.appindicator  # bg apps
    gnomeExtensions.bing-wallpaper-changer
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.dash-to-panel  # taskbar
    gnomeExtensions.touch-x  # touch ripples
    rclone  # onedrive
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
