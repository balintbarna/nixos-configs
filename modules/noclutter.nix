{ pkgs, ... }: {
  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    gnome-maps
    gnome-shell-extensions
    simple-scan
    yelp
  ]);
  #
  documentation.nixos.enable = false;
  #
  services.xserver.excludePackages = [ pkgs.xterm ];
}
