{ pconf, ... }: {
  imports = [
    ./nextcloud.nix
  ];
  # Let's Encrypt ACME
  security.acme = {
    acceptTerms = true;
    defaults.email = pconf.mail.info;
  };
  # Reverse proxy
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    clientMaxBodySize = "20G";
  };
}
