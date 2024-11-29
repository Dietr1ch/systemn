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
      enable = true;

      settings = {
        # DefaultAction = "deny";

        # Use nftables as the Firewall
        Firewall = "nftables";
      };
      rules = {

        systemd-timesyncd = {
          name = "systemd-timesyncd";
          enabled = true;
          action = "allow";
          duration = "always";
          operator = {
            type ="simple";
            sensitive = false;
            operand = "process.path";
            data = "${lib.getBin pkgs.systemd}/lib/systemd/systemd-timesyncd";
          };
        };

        systemd-resolved = {
          name = "systemd-resolved";
          enabled = true;
          action = "allow";
          duration = "always";
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


