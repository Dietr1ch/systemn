{ config, lib, pkgs, ... }:

{
  # https://nixos.wiki/wiki/Networking
  # https://search.nixos.org/options?channel=unstable&query=networking
  networking = {
    enable = true;

    enableIPv6 = true;

    # https://search.nixos.org/options?channel=unstable&query=networking.networkmanager
    networkmanager = {
      enable = true;

      dns = lib.mkDefault "default";

      ethernet = {
        macAddress = "random";
      };
      wifi = {
        backend = "iwd";
        # backend = "wpa_supplicant";
        powersave = true;

        scanRandMacAddress = true;
        macAddress = lib.mkDefault "random";
        # macAddress = "stable-ssid";
      };
    };
  };
}
