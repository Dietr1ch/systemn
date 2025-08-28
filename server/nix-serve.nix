{
  config,
  lib,
  pkgs,
  ...
}:

{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=nix-serve
    #
    # Listens HTTP on 127.0.0.1:5000
    nix-serve = {
      enable = true;
      # Use nix-serve-ng. https://github.com/aristanetworks/nix-serve-ng
      package = pkgs.nix-serve-ng;

      bindAddress = "127.0.0.1";
      port = 5000;

      openFirewall = true;
      extraParams = lib.concatStringsSep " " [
        "--priority 35" # Slightly higher priority than https://cache.nixos.org/nix-cache-info
      ];

      # ../secrets.nix
      # Generate keys with,
      # sudo nix-store \
      #   --generate-binary-cache-key \
      #   "nix-store--$(hostname)" \
      #   /var/nix-store-private.pem \
      #   /var/nix-store-public.pem
      # secretKeyFile = "/var/nix-store-private.pem";
    };

    nginx = {
      virtualHosts = {
        "${config.networking.hostName}.local" = {
          locations = {
            "/nix/" = {
              proxyPass =
                let
                  addr = config.services.nix-serve.bindAddress;
                  port = config.services.nix-serve.port;
                in
                "http://${addr}:${toString port}/";
              # proxyWebsockets = true;
              recommendedProxySettings = true;
            };
          };
        };
      };
    };
  };

  environment = {
    etc = {
      "avahi/services/nix-serve.service" = {
        mode = "0444";
        text = ''
          <?xml version="1.0" standalone="no"?>
          <!DOCTYPE service-group SYSTEM "nix-serve-service.dtd">

          <service-group>
            <name replace-wildcards="yes">nix-serve server at %h</name>
            <service>
              <type>_nix-serve._tcp</type>
              <port>${toString config.services.nix-serve.port}</port>
            </service>
          </service-group>
        '';
      };
    };
  };
}
