{
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-24.05;
    unstable.url = github:nixos/nixpkgs/nixos-unstable;
    nixos-hardware.url = github:NixOS/nixos-hardware/master;
    lanzaboote = {
      url = github:nix-community/lanzaboote/v0.3.0;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    openbar-nixpkgs.url = "github:balintbarna/nixpkgs/openbar-init";
  };
  outputs = { nixpkgs, unstable, home-manager, openbar-nixpkgs, ... }@attrs: let
    pconf = (import ./modules/sensitive.secret.nix);
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
    rolling = import unstable { inherit system; config.allowUnfree = true; };
    openbar = import openbar-nixpkgs { inherit system; };
    extraSpecialArgs = { inherit rolling openbar pconf; };
    specialArgs = attrs // extraSpecialArgs;
  in {
    nixosConfigurations = {
      "${pconf.user}-surfacepro" = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [ ./hosts/surfacepro6/conf.nix ];
      };
      "${pconf.user}-tower" = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [ ./hosts/tower/conf.nix ];
      };
      "${pconf.user}-ally" = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [ ./hosts/ally/conf.nix ];
      };
      vps = nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = [ ./hosts/vps/conf.nix ];
      };
    };
    homeConfigurations = {
      "${pconf.user}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs extraSpecialArgs;
        modules = [ ./modules/home.nix ];
      };
    };
    devShell."${system}" = import ./shell.nix { inherit pkgs; };
    devShell."aarch64-linux" = import ./shell.nix { inherit pkgs; };
  };
}
