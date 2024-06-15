{ pkgs, rolling, pconf, ... }: {
  imports = [
    ./theming.nix
  ];
  home.packages = (with pkgs; [
    apostrophe  # markdown editor
    bitwarden  # passwords
    blanket  # soothing sounds
    brave  # browser
    collision  # hash checker
    curtail  # image compression
    gnome-decoder  # QR codes
    dialect  # translator
    diebahn  # public transport schedule
    easyeffects  # bass boost and more
    element-desktop  # matrix chat
    evolution  # to set up mail accounts
    eyedropper  # color picker
    foliate  # ebook reader
    fragments  # torrent
    gimp  # image editor
    git-crypt  # secrets in git repos
    impression  # ISO burner
    junction  # app chooser for links
    khronos  # time tracker
    libreoffice  # document editor
    localsend  # portable local network file sharing
    nextcloud-client  # drive
    gnome-obfuscate  # censor images
    shortwave  # radio
    gnome-solanum  # pomodoro timer
    spotify  # music
    stremio  # movies / tv
    switcheroo  # convert images
    sysprof  # profile apps or system
    textpieces  # encode/format text
    gnome.gnome-tweaks  # desktop theming
    video-trimmer  # trim videos
    vscode  # code editor
  ]) ++ (with pkgs.gnomeExtensions; [
    appindicator  # background apps icon
    bing-wallpaper-changer  # nice wallpapers
    blur-my-shell  # background on overview
    clipboard-indicator  # clipboard history
    rolling.gnomeExtensions.fullscreen-to-empty-workspace
    status-area-horizontal-spacing  # less space waste
  ]);
  #
  programs.git = {
    enable = true;
    extraConfig.user = {
      name = pconf.name;
      email = pconf.mail.personal;
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
