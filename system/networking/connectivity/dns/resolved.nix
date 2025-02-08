{ lib, pkgs, ... }:

{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.resolved
    #
    # Listens DNS on 127.0.0.53:53 and 127.0.0.54:53
    resolved = {
      enable = lib.mkDefault true;

      # Setting fallbackDns to avoid default list
      fallbackDns = [
        "127.0.0.55"  # adguardhome
        # "127.0.0.56"  # dnscrypt-proxy2 (behind adguardhome already)
      ];
    };  # ..services.resolved

    opensnitch = {
      rules = {

        # INTENT: Anyone can query resolved at 127.0.0.1:53
        "0-OPEN-resolved-1" = {
          created = "2024-11-27T22:00:00-03:00";
          updated = "2024-11-27T22:00:00-03:00";

          name = "0-OPEN-resolved-1";
          enabled = true;
          precedence = true;
          action = "allow";
          duration = "always";
          operator = {
            operand = "list";

            list = [
              {
                operand = "dest.ip";

                data = "127.0.0.1";
                type = "simple";
              }
              {
                operand = "dest.port";

                data = "53";
                type = "simple";
              }
            ];
            type = "list";
          };
        };  # "0-OPEN-resolved-1"
        # INTENT: Anyone can query resolved at 127.0.0.53:53
        "0-OPEN-resolved-53" = {
          created = "2024-11-27T22:00:00-03:00";
          updated = "2024-11-27T22:00:00-03:00";

          name = "0-OPEN-resolved-53";
          enabled = true;
          precedence = true;
          action = "allow";
          duration = "always";
          operator = {
            operand = "list";

            list = [
              {
                operand = "dest.ip";

                data = "127.0.0.53";
                type = "simple";
              }
              {
                operand = "dest.port";

                data = "53";
                type = "simple";
              }
            ];
            type = "list";
          };
        };  # "0-OPEN-resolved-53"
        # TODO: Allow querying resolved at 127.0.0.54:53

        # INTENT: Resolved can reach AdGuardHome
        "0-ALLOW-resolved-adguardhome" = {
          created = "2024-11-27T22:00:00-03:00";
          updated = "2024-11-27T22:00:00-03:00";

          name = "0-ALLOW-resolved-adguardhome";
          enabled = true;
          precedence = true;
          action = "allow";
          duration = "always";
          operator = {
            operand = "list";

            list = [
              # NOTE: AdGuardHome runs at 127.0.0.55:53
              {
                operand = "dest.ip";

                data = "127.0.0.55";
                type = "simple";
              }
              {
                operand = "dest.port";

                data = "53";
                type = "simple";
              }
              {
                operand = "process.path";

                data = "${lib.getBin pkgs.systemd}/lib/systemd/systemd-resolved";
                type ="simple";
              }
            ];
            type = "list";
          };
        };  # "0-ALLOW-resolved-adguardhome"

      };  # ..services.opensnitch.rules
    };  # ..services.opensnitch
  };  # ..services

  # https://nixos.wiki/wiki/Networking
  networking = {
    enableIPv6 = true;

    # https://search.nixos.org/options?channel=unstable&query=networking.nameservers
    nameservers = [
      # NOTE: Can't use specify ports (:53) as it breaks bandwhich's resolve.conf parsing.

      # "127.0.0.53"  # resolved. Self
      # "127.0.0.54"  # resolved. Self
      "127.0.0.55"  # adguardhome
      # "127.0.0.56"  # dnscrypt-proxy2 (behind adguardhome already)
    ];  # ..networking.nameservers

    # https://search.nixos.org/options?channel=unstable&query=networking.networkmanager
    networkmanager = {
      enable = true;

      dns = lib.mkDefault "none";

      connectionConfig = {
        # Enable mdns resolution for resolved on all connections
        # See https://man.archlinux.org/man/NetworkManager.conf.5#CONNECTION_SECTION
        "connection.mdns" = 2;
      };
    };  # ..networking.networkmanager

    # https://search.nixos.org/options?channel=unstable&query=networking.resolvconf
    resolvconf = {
      useLocalResolver = false;
    };
  };  # ..networking
}
