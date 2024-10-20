{ config, lib, pkgs, ... }:

{
  # https://nixos.wiki/wiki/Nginx
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.nginx
    nginx = {
      enable = true;

      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      # recommendedTlsSettings = true;

      # Config file mentioned in /etc/systemd/system/nginx.service
      virtualHosts = {

        # $HOSTNAME.local
        "${config.networking.hostName}.local" = {
          # addSSL = true;
          # enableACME = true;

          # https://search.nixos.org/options?channel=unstable&show=services.nginx.virtualHosts.%3Cname%3E.locations
          # https://nginx.org/en/docs/http/ngx_http_core_module.html#location
          locations = {
            "~ /\\." = {
              extraConfig = ''
			          deny all;
              '';
            };

            "/" = {
              # /srv/web/$HOSTNAME
              root = "/srv/web/${config.networking.hostName}/";
            };
          };
        };

      };
    };
  };

  # https://nixos.wiki/wiki/ACME
  security = {
    acme = {
      # acceptTerms = true;
      # defaults = {
      # };
    };
  };

  networking = {
    firewall = {
      allowedTCPPorts = [
        80   # Default HTTP
        443  # Default HTTPS
      ];
    };
  };
}
