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

      virtualHosts = {
        "${config.networking.hostName}.local" = {
          # addSSL = true;
          # enableACME = true;

          locations = {
            "/" = {
              # /srv/web/
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
