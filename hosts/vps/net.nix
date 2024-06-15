{ pconf, ... }: {
  networking = {
    hostName = "vps";
    useDHCP = true;
    nameservers = [
      "2a01:4ff:ff00::add:2"
      "2a01:4ff:ff00::add:1"
    ];
    interfaces.enp1s0.ipv6.addresses = [{
      address = pconf.vps.ip6;
      prefixLength = 64;
    }];
    defaultGateway6 = {
      address = "fe80::1";
      interface = "enp1s0";
    };
    firewall.enable = true;
    firewall.allowedTCPPorts = [ 80 443 ];
    # firewall.allowedUDPPorts = [ ... ];
    nat = {
      enable = true;
      internalInterfaces = ["ve-+"];
      externalInterface = "enp1s0";
      # Lazy IPv6 connectivity for the container
      enableIPv6 = true;
    };
  };
}
