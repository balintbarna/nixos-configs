{ pkgs, ... }: {
  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    gnome-maps
    simple-scan
    yelp
  ]);
  #
  documentation.nixos.enable = false;
}
