{ pkgs, pconf, ... }: {
  imports = [
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
    rclone  # onedrive
    spotify
    stremio
    terminator
    vscode
  ]) ++ (with pkgs.gnomeExtensions; [
    appindicator  # bg apps icon
    auto-activities  # when there are no windows
    bing-wallpaper-changer
    blur-my-shell
    clipboard-indicator
    dash-to-panel  # taskbar
    fullscreen-to-empty-workspace
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
  systemd.user.services.onedrived = {
    Unit = {
      Description = "Onedrive mount";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      Type = "oneshot";
      RemainAfterExit = "yes";
      ExecStart = "${pkgs.rclone}/bin/rclone mount onedrive: /home/${pconf.user}/OneDrive --vfs-cache-mode writes --daemon";
      ExecStop = "${pkgs.coreutils}/bin/umount /home/${pconf.user}/OneDrive";
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
