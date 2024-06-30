{ pkgs, ... }: {
  dconf.settings = {
    "org/gnome/desktop/wm/preferences".button-layout = ":close";
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
    };
    "org/gnome/mutter" = {
      dynamic-workspaces = true;
      edge-tiling = true;
    };
    "org/gnome/shell" = {
      disabled-extensions = [];
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "BingWallpaper@ineffable-gmail.com"
        # "blur-my-shell@aunetx"
        "clipboard-indicator@tudmotu.com"
        "fullscreen-to-empty-workspace@aiono.dev"
        "openbar@neuromorph"
        # "status-area-horizontal-spacing@mathematical.coffee.gmail.com"
      ];
    };
  };  # inspiration from: dconf watch /
  #
  gtk = with pkgs; {
    enable = true;
    iconTheme = { name = "WhiteSur-dark"; package = whitesur-icon-theme; };
    theme = { name = "Adwaita"; };
    cursorTheme = { name = "Bibata-Modern-Ice"; package = bibata-cursors; };
    gtk3.extraConfig = { gtk-application-prefer-dark-theme = 1; };
    gtk4.extraConfig = { gtk-application-prefer-dark-theme = 1; };
  };
  home.sessionVariables.GTK_THEME = "Adwaita";
}
