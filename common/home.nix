{ pkgs, pconf, ... }: {
  imports = [
    ./onedrive.nix
    ./online-accounts.nix
    ./theming.nix
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
    libreoffice
    spotify
    stremio
    vscode
  ]) ++ (with pkgs.gnomeExtensions; [
    appindicator  # bg apps icon
    auto-activities  # when there are no windows
    bing-wallpaper-changer
    blur-my-shell
    clipboard-indicator
    dash-to-panel  # taskbar
    fullscreen-to-empty-workspace
    removable-drive-menu
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
  nixpkgs.config.allowUnfree = true;
  #
  home.username = pconf.user;
  home.homeDirectory = pconf.home;
  #
  home.enableNixpkgsReleaseCheck = false;
  home.stateVersion = "23.11";
}
