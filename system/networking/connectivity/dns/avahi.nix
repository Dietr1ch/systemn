{ config, lib, ... }:

{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.avahi
    # ~/Code/github/Dietr1ch/nixpkgs/nixos/modules/services/networking/avahi-daemon.nix
    avahi = {
      enable = lib.mkDefault true;

      ipv4 = true;
      ipv6 = true;

      nssmdns4 = true;
      # Whether to enable the mDNS NSS (Name Service Switch) plug-in for IPv6.
      # Enabling it allows applications to resolve names in the .local domain by
      # transparently querying the Avahi daemon.
      # Due to the fact that most mDNS responders only register local IPv4
      # addresses, most user want to leave this option disabled to avoid long
      # timeouts when applications first resolve the none existing IPv6 address.
      nssmdns6 = false;

      openFirewall = true;

      publish = {
        enable = true;

        addresses = true;
        workstation = true;  # Register a service of type “_workstation._tcp” on the local LAN.
        userServices = true;
      };
    };  # ..services.avahi

    opensnitch = {
      # https://github.com/evilsocket/opensnitch/wiki/Rules
      rules = {

        # XXX: Should be enabled by default once we match with `user.name`
        "0-ALLOW-Avahi-IPv4_multicast" = lib.mkIf (config.users.users.avahi.uid != null) {
          created = "2024-12-10T22:00:00-03:00";
          updated = "2024-12-10T22:00:00-03:00";

          name = "0-ALLOW-Avahi-IPv4_multicast";
          enabled = true;
          precedence = true;
          action = "allow";
          duration = "always";
          operator = {
            operand = "list";

            list = [
              {
                operand = "dest.network";

                data = "224.0.0.0/24";  # IPv4 Multicast (https://en.wikipedia.org/wiki/Multicast_address#IPv4)
                type = "network";
              }
              {
                operand = "dest.port";

                data = "5353";
                type = "simple";
              }
              {
                # TODO: Use the `user.name` matcher once supported (https://github.com/evilsocket/opensnitch/issues/1236)
                operand = "user.id";

                data = "${toString config.users.users.avahi.uid}";
                type = "simple";
              }
            ];
            type = "list";
          };
        };  # "0-ALLOW-Avahi-IPv4_multicast"

        # XXX: Should be enabled by default once we match with `user.name`
        "0-ALLOW-Avahi-IPv6_multicast" = lib.mkIf (config.users.users.avahi.uid != null) {
          created = "2024-12-10T22:00:00-03:00";
          updated = "2024-12-10T22:00:00-03:00";

          name = "0-ALLOW-Avahi-IPv6_multicast";
          enabled = true;
          precedence = true;
          action = "allow";
          duration = "always";
          operator = {
            operand = "list";

            list = [
              {
                operand = "dest.network";

                # Link-local IPv6 Multicast (https://en.wikipedia.org/wiki/Multicast_address#IPv6)
                # NOTE: Address is actually ffX2::/16, but the flags under X don't matter.
                data = "ff02::/16";
                type = "network";
              }
              {
                operand = "dest.port";

                data = "5353";
                type = "simple";
              }
              {
                # TODO: Use the `user.name` matcher once supported (https://github.com/evilsocket/opensnitch/issues/1236)
                operand = "user.id";

                data = "${toString config.users.users.avahi.uid}";
                type = "simple";
              }
            ];
            type = "list";
          };
        };  # "0-ALLOW-Avahi-IPv6_multicast"

      };  # ..services.opensnitch.rules
    };  # ..services.opensnitch
  };  # ..services
}
