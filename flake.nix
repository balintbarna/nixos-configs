{
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/2be119add7b37dc535da2dd4cba68e2cf8d1517e;  # 23.11
    nixos-hardware.url = github:NixOS/nixos-hardware/59e37017b9ed31dee303dbbd4531c594df95cfbc;  # 2024.3.2
    lanzaboote = {  # v0.3.0
      url = github:nix-community/lanzaboote/64b903ca87d18cef2752c19c098af275c6e51d63;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {  # 23.11
      url = "github:nix-community/home-manager/652fda4ca6dafeb090943422c34ae9145787af37";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { nixpkgs, home-manager, ... }@attrs: let
    pconf = (import ./modules/pconf.nix.secret);
    system = "x86_64-linux";
    specialArgs = attrs // { inherit pconf; };
    pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
    extraSpecialArgs = { inherit pconf; };
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
    };
    homeConfigurations = {
      "${pconf.user}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs extraSpecialArgs;
        modules = [ ./modules/home.nix ];
      };
    };
    devShells."${system}".default = import ./shell.nix { inherit pkgs; };
  };
}
