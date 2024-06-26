{ pkgs, pconf, ... }: let
  host_address = "192.168.100.10";
  guest_address = "192.168.100.11";
in {
  # Reverse proxy for collabora
  services.nginx.virtualHosts."${pconf.domain.collabora}" = {
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://localhost:9980";
      proxyWebsockets = true;
    };
  };
  # Collabora CODE server in a container
  virtualisation.oci-containers = {
    backend = "podman";
    containers.collabora = {
      image = "collabora/code";
      ports = ["9980:9980"];
      environment = {
        domain = "${pconf.domain.nextcloud}";
        extra_params = "--o:ssl.enable=false --o:ssl.termination=true";
      };
      extraOptions = ["--cap-add" "MKNOD"];
    };
  };
  # Reverse proxy for Nextcloud
  services.nginx.virtualHosts."${pconf.domain.nextcloud}" = {
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://${guest_address}";
      proxyWebsockets = true;
      extraConfig = ''
        proxy_redirect http://$host https://$host;  # required for apps
      '';
    };
  };
  # Nextcloud container service timing
  systemd.services."containers@nextcloud" = {
    after = [ "mnt-box.mount" ];
    wants = [ "mnt-box.mount" ];
  };
  # Nextcloud server in a container
  containers.nextcloud = {
    ephemeral = true;
    autoStart = true;
    privateNetwork = true;
    hostAddress = host_address;
    localAddress = guest_address;
    hostAddress6 = "fc00::1";
    localAddress6 = "fc00::2";
    bindMounts = {
      "/secrets" = { hostPath = "/persistent/nextcloud/secrets"; };
      "/var/lib/nextcloud" = {
        hostPath = "/persistent/nextcloud/home";
        isReadOnly = false;
      };
      "/var/lib/nextcloud/data" = {
        hostPath = "/mnt/box/nextcloud/data";
        isReadOnly = false;
      };
        "/var/lib/postgresql" = {
        hostPath = "/persistent/nextcloud/db";
        isReadOnly = false;
      };
    };
    config = { pkgs, config, ... }: {
      systemd.tmpfiles.rules = [
        "d /var/lib/nextcloud 700 nextcloud nextcloud -"
        "d /var/lib/postgresql 700 nextcloud nextcloud -"
        "d /var/lib/nextcloud/data 700 nextcloud nextcloud -"
      ];
      networking.firewall.enable = false;
      services.nextcloud = {
        enable = true;
        package = pkgs.nextcloud29;
        hostName = pconf.domain.nextcloud;
        https = true;
        maxUploadSize = "20G";
        configureRedis = true;
        database.createLocally = true;
        config = {
          dbtype = "pgsql";
          adminuser = pconf.mail.business;
          adminpassFile = "/secrets/pw";
        };
        settings = {
          trusted_proxies = [ host_address ];
          maintenance_window_start = 1;
          log_type = "file";
          mail_smtpmode = "smtp";
          mail_smtphost = pconf.mail.smtp;
          mail_smtpport = 465;
          mail_smtpsecure = "ssl";
          mail_smtpauth = true;
          mail_smtpname = pconf.mail.business;
          mail_from_address = "cloud";
          mail_domain = pconf.domain.business;
        };
        phpOptions = {
          "opcache.interned_strings_buffer" = "20";
        };
        appstoreEnable = true;
        extraAppsEnable = true;
        extraApps = with config.services.nextcloud.package.packages.apps; {
          inherit
            # bookmarks
            calendar
            contacts
            deck
            end_to_end_encryption
            forms
            groupfolders
            mail
            notes
            notify_push
            polls
            richdocuments
            tasks;
        };
      };
      system.stateVersion = "24.05";
    };
  };
}
