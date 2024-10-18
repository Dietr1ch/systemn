{ config, lib, pkgs, ... }:

{
  # https://nixos.wiki/wiki/Nginx
  services = {
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
}
