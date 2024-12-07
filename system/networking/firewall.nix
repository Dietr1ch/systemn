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
  };

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

        systemd-timesyncd = {
          created = "2024-11-27T14:00:00Z04:00";
          updated = "2024-11-27T14:00:00Z04:00";

          name = "systemd-timesyncd";
          enabled = true;
          precedence = false;
          action = "allow";
          duration = "always";
          operator = {
            type = "simple";
            sensitive = false;
            operand = "process.path";
            data = "${lib.getBin pkgs.systemd}/lib/systemd/systemd-timesyncd";
          };
        };

        "0-Allow-resolved" = {
          created = "2024-11-27T14:00:00Z04:00";
          updated = "2024-11-27T14:00:00Z04:00";

          name = "0-Allow-resolved";
          enabled = true;
          precedence = true;
          action = "allow";
          duration = "always";
          # TODO: Restrict to loopback
          operator = {
            type ="simple";
            sensitive = false;
            operand = "process.path";
            data = "${lib.getBin pkgs.systemd}/lib/systemd/systemd-resolved";
          };
        };

      };
    };
  };
}


