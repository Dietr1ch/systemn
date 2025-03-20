{ config, lib, pkgs, ... }:

{
  imports = [
    ./connectivity  # connectivity/default.nix

    ./information.nix
    ./firewall.nix
    ./tools.nix
  ];

  boot = {
    kernel = {
      sysctl = {
        # https://wiki.archlinux.org/title/Sysctl#Enable_TCP_Fast_Open
        "net.ipv4.tcp_fastopen" = 3;
      };
    };
  };

  # https://search.nixos.org/options?channel=unstable&query=networking
  networking = {
    dhcpcd = {
      enable = true;

      wait = "background";

      extraConfig = ''
        noarp  # Avoid checking if the IP is taken
      '';
    };
  };
}
