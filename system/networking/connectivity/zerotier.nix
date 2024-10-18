{ config, lib, pkgs, ... }:

{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.zerotierone
    zerotierone = {
      enable = true;
      joinNetworks = [
        # ../../secrets.nix
      ];
    };
  };

  # nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
  #   "zerotierone"
  # ];
}
