{ pkgs, lib, ... }:

{
  # https://search.nixos.org/options?channel=unstable&query=nix
  nix = {
    channel.enable = false;

    optimise = {
      automatic = lib.mkDefault false;
    }; # ..nix.optimise

    # Generates /etc/nix/nix.conf
    # https://nix.dev/manual/nix/2.35/command-ref/conf-file.html#available-settings
    settings = {
      nix-path = [ "nixpkgs=${pkgs.path}" ];

      # Config
      # https://nix.dev/manual/nix/2.35/command-ref/conf-file.html#conf-use-xdg-base-directories
      use-xdg-base-directories = true;

      # https://nix.dev/manual/nix/2.35/command-ref/conf-file.html#conf-fallback
      fallback = true; # Ensure we can still build when a server is not accessible

      # https://nix.dev/manual/nix/2.35/command-ref/conf-file.html#conf-use-cgroups
      use-cgroups = lib.mkDefault true;
      # https://nix.dev/manual/nix/2.35/command-ref/conf-file.html#conf-extra-experimental-features
      extra-experimental-features = [
        "nix-command" # https://nix.dev/manual/nix/2.35/development/experimental-features.html#xp-feature-nix-command
        "flakes" # https://nix.dev/manual/nix/2.35/development/experimental-features.html#xp-feature-flakes
        "cgroups" # https://nix.dev/manual/nix/2.35/development/experimental-features.html#xp-feature-cgroups
        "fetch-tree" # https://nix.dev/manual/nix/2.35/development/experimental-features.html#xp-feature-fetch-tree
        "blake3-hashes" # https://nix.dev/manual/nix/2.35/development/experimental-features.html#xp-feature-blake3-hashes
        "git-hashing" # https://nix.dev/manual/nix/2.35/development/experimental-features.html#xp-feature-git-hashing
        # TODO: Try out ca-derivations once the devenv incompatibily is resolved. (https://github.com/cachix/devenv/issues/2364)
        # "ca-derivations" # https://nix.dev/manual/nix/2.35/development/experimental-features.html#xp-feature-ca-derivations
        "pipe-operators" # https://nix.dev/manual/nix/2.35/development/experimental-features.html#xp-feature-pipe-operators
      ];

      # Storage
      # https://nix.dev/manual/nix/2.35/command-ref/conf-file.html#conf-auto-optimise-store
      auto-optimise-store = lib.mkDefault false;
      # https://nix.dev/manual/nix/2.35/command-ref/conf-file.html#conf-preallocate-contents
      preallocate-contents = lib.mkDefault true;

      # Builds
      # https://nix.dev/manual/nix/2.35/command-ref/conf-file.html#conf-max-jobs
      # https://nix.dev/manual/nix/2.35/command-ref/conf-file.html#conf-cores

      # Downloads
      # https://nix.dev/manual/nix/2.35/command-ref/conf-file.html#conf-substituters
      extra-substituters = [
        # Cache v2
        # https://nixos.wiki/wiki/Maintainers:Fastly
        "https://aseipp-nix-cache.global.ssl.fastly.net" # Beta IPv4-only
        "https://aseipp-nix-cache.freetls.fastly.net" # Beta + IPv6 + HTTP/2

        # nixpkgs-update-cache (don't query by default)
        # "http://nixpkgs-update-cache.nix-community.org"
      ];
      # https://nix.dev/manual/nix/2.35/command-ref/conf-file.html#conf-trusted-public-keys
      extra-trusted-public-keys = [
        # (Cache v2 uses the same public keys)

        # nixpkgs-update-cache
        "nixpkgs-update-cache.nix-community.org-1:U8d6wiQecHUPJFSqHN9GSSmNkmdiFW7GW7WNAnHW0SM="
      ];

      # https://nix.dev/manual/nix/2.35/command-ref/conf-file.html#conf-max-substitution-jobs
      max-substitution-jobs = lib.mkDefault 24;
      # https://nix.dev/manual/nix/2.35/command-ref/conf-file.html#conf-http-connections
      http-connections = lib.mkDefault 50;
      # https://nix.dev/manual/nix/2.35/command-ref/conf-file.html#conf-connect-timeout
      # Corresponds to curl's --connect-timeout.
      connect-timeout = lib.mkDefault 5;
      # https://nix.dev/manual/nix/2.35/command-ref/conf-file.html#conf-download-attempts
      download-attempts = lib.mkDefault 3;
    }; # ..nix.settings

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    }; # ..nix.gc
  }; # ..nix

  # https://search.nixos.org/options?channel=unstable&query=systemd
  systemd = {
    services = {
      # /etc/systemd/system/nix-daemon.service
      "nix-daemon" = {
        # https://www.freedesktop.org/software/systemd/man/systemd.service.html
        serviceConfig = {
          # Resource Control
          # ----------------
          # https://www.freedesktop.org/software/systemd/man/latest/systemd.resource-control.html#

          # https://www.freedesktop.org/software/systemd/man/latest/systemd.resource-control.html#CPUWeight=weight
          CPUWeight = "idle";
        };
      }; # ..systemd.services."nix-daemon"
    }; # ..systemd.services
  }; # ..systemd
}
