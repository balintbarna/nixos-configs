{ pkgs, pconf, ... }: {
  imports = [
    ./onedrive.nix
    ./online-accounts.nix
    ./theming.nix
  ];
  home.packages = (with pkgs; [
    authy  # 2FA OTP codes
    bitwarden  # passwords
    brave  # browser
    easyeffects  # bass boost and more
    element-desktop  # matrix chat
    evolution  # to set up mail accounts
    fragments  # torrent
    gimp  # image editor
    git-crypt  # secrets in git repos
    gnome.gnome-tweaks  # theming
    libreoffice  # document editor
    spotify  # music
    stremio  # movies / tv
    vscode  # code editor
  ]) ++ (with pkgs.gnomeExtensions; [
    appindicator  # bg apps icon
    auto-activities  # when there are no windows
    bing-wallpaper-changer  # nice wallpapers
    blur-my-shell  # background on overview
    clipboard-indicator  # clipboard history
    dash-to-panel  # taskbar
    fullscreen-to-empty-workspace
    removable-drive-menu  # unmount drives
    status-area-horizontal-spacing  # less space waste
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
