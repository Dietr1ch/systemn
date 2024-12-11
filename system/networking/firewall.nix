{ config, lib, pkgs, ... }:

{
  networking = {
    # https://nixos.wiki/wiki/Firewall
    # https://search.nixos.org/options?channel=unstable&query=networking.firewall
    firewall = {
      enable = true;

      allowPing = true;
    };

    # Use nftables as the Firewall
    nftables = {
      enable = true;
    };
  };  # ..networking

  services = {
    # https://wiki.nixos.org/wiki/OpenSnitch
    # https://search.nixos.org/options?channel=unstable&query=services.opensnitch
    opensnitch = {
      enable = lib.mkDefault true;

      # https://search.nixos.org/options?channel=unstable&query=services.opensnitch.settings
      settings = {
        # DefaultAction = lib.mkDefault "deny";

        # Use nftables as the Firewall
        Firewall = "nftables";
      };
      rules = {

        "0-ALLOW-timesyncd" = {
          created = "2024-11-27T22:00:00-03:00";
          updated = "2024-11-27T22:00:00-03:00";

          name = "0-ALLOW-timesyncd";
          enabled = true;
          precedence = false;
          action = "allow";
          duration = "always";
          operator = {
            operand = "process.path";

            data = "${lib.getBin pkgs.systemd}/lib/systemd/systemd-timesyncd";
            type = "simple";
          };
        };  # "0-ALLOW-timesyncd"

      };  # ..services.opensnitch.rules
    };  # ..services.opensnitch
  };  # ..services
}


