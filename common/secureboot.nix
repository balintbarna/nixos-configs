{ config, pkgs, lib, ... }:
let
  lanzaboote = builtins.fetchGit {
    name = "lanzaboote-0.3.0";
    url = "https://github.com/nix-community/lanzaboote/";
    ref = "refs/tags/v0.3.0";
    submodules = true;
  };
in {
  imports = [
    # "${lanzaboote}/nixosModules/lanzaboot/"
    "${lanzaboote}/nix/modules/lanzaboote.nix"
  ];
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };
}