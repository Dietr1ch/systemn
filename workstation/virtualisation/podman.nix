{ config, lib, pkgs, ... }:

{
  # https://nixos.wiki/wiki/Podman
  virtualisation = {
    containers = {
      # Enable common container config files in /etc/containers
      enable = true;
    };

    podman = {
      enable = true;
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
    oci-containers = {
      backend = "podman";
    };
  };

  environment = {
    systemPackages = with pkgs; [
      dive # look into docker image layers
      podman-tui # status of containers in the terminal
      podman-compose # start group of containers for dev
    ];
  };
}
