{ config, lib, pkgs, ... }:

{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.monero
    monero = {
      enable = true;

      limits = {
        threads = 4;

        upload   = 25;  # 25kb/s
        download = 25;  # 25kb/s
      };
    };
  };
}
