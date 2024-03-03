{ config, ... }:
{
  imports = [
    /etc/nixos/hardware-configuration.nix
    ../devices/sp6.nix
  ];
}
