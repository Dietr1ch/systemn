{ config, ... }:

{
  # https://nixos.wiki/wiki/Nginx
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.nginx
    # ~/Projects/nixpkgs/nixos/modules/services/web-servers/nginx/default.nix
    nginx = {
      enable = true;

      recommendedOptimisation = true;
      # Connection
      recommendedProxySettings = true;
      # recommendedTlsSettings = true;

      # Compression
      recommendedGzipSettings = true;
      # Config file mentioned in /etc/systemd/system/nginx.service
      virtualHosts = {

        # $HOSTNAME.local
        "${config.networking.hostName}.local" = {
          # addSSL = true;
          # enableACME = true;

          # https://search.nixos.org/options?channel=unstable&query=services.nginx.virtualHosts.%3Cname%3E.locations
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

    prometheus = {
      exporters = {
        node = {
          enabledCollectors = [
            # "nginx"
            # "nginxlog"
          ];
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
        80 # Default HTTP
        443 # Default HTTPS
      ];
    };
  };
}
