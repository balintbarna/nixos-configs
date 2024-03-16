{ pkgs, ... }: {
  dconf.settings = {
    "org/gnome/desktop/wm/preferences".button-layout = ":minimize,close";
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
    };
    "org/gnome/mutter" = {
      dynamic-workspaces = true;
      edge-tiling = true;
    };
  };  # inspiration from: dconf watch /
  #
  gtk = with pkgs; {
    enable = true;
    iconTheme = { name = "WhiteSur-dark"; package = whitesur-icon-theme; };
    theme = { name = "Orchis-Dark"; package = orchis-theme; };
    cursorTheme = { name = "Bibata-Modern-Ice"; package = bibata-cursors; };
    gtk3.extraConfig = { Settings = "gtk-application-prefer-dark-theme=1"; };
    gtk4.extraConfig = { Settings = "gtk-application-prefer-dark-theme=1"; };
  };
  home.sessionVariables.GTK_THEME = "Orchis-Dark";
}
