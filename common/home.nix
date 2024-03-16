{ pkgs, pconf, ... }: {
  imports = [
    ./online-accounts.nix
  ];
  home.packages = (with pkgs; [
    authy  # MFA codes
    bitwarden  # passwords
    brave  # browser
    easyeffects  # bass boost and more
    element-desktop  # matrix chat
    evolution  # to set up mail accounts
    gimp
    git-crypt  # secrets in git repos
    gnome.gnome-tweaks
    rclone  # onedrive
    spotify
    stremio
    terminator
    vscode
  ]) ++ (with pkgs.gnomeExtensions; [
    appindicator  # bg apps icon
    auto-activities  # when there are no windows
    bing-wallpaper-changer
    clipboard-indicator
    dash-to-panel  # taskbar
    fullscreen-to-empty-workspace
    overview-background
    status-area-horizontal-spacing
    touch-x  # touch ripples
  ]);
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
