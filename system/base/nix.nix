{ lib, ... }:

{
  # https://search.nixos.org/options?channel=unstable&query=nix
  nix = {
    optimise = {
      automatic = lib.mkDefault false;
    };

    # Generates /etc/nix/nix.conf
    # https://nix.dev/manual/nix/2.24/command-ref/conf-file.html#available-settings
    settings = {
      # Config
      # https://nix.dev/manual/nix/2.24/command-ref/conf-file.html#conf-use-cgroups
      use-cgroups = lib.mkDefault true;
      # https://nix.dev/manual/nix/2.24/command-ref/conf-file.html#conf-extra-experimental-features
      extra-experimental-features = [
        "nix-command" # https://nix.dev/manual/nix/2.32/development/experimental-features.html#xp-feature-nix-command
        "flakes" # https://nix.dev/manual/nix/2.32/development/experimental-features.html#xp-feature-flakes
        "cgroups" # https://nix.dev/manual/nix/2.32/development/experimental-features.html#xp-feature-cgroups
        "fetch-tree" # https://nix.dev/manual/nix/2.32/development/experimental-features.html#xp-feature-fetch-tree
        "blake3-hashes" # https://nix.dev/manual/nix/2.32/development/experimental-features.html#xp-feature-blake3-hashes
        "git-hashing" # https://nix.dev/manual/nix/2.32/development/experimental-features.html#xp-feature-git-hashing
        "ca-derivations" # https://nix.dev/manual/nix/2.32/development/experimental-features.html#xp-feature-ca-derivations
      ];

      # Storage
      # https://nix.dev/manual/nix/2.24/command-ref/conf-file.html?highlight=max-substitution-jobs#conf-auto-optimise-store
      auto-optimise-store = lib.mkDefault false;
      # https://nix.dev/manual/nix/2.24/command-ref/conf-file.html#conf-preallocate-contents
      preallocate-contents = lib.mkDefault true;

      # Builds
      # https://nix.dev/manual/nix/2.24/command-ref/conf-file.html?highlight=max-substitution-jobs#conf-max-jobs
      # https://nix.dev/manual/nix/2.24/command-ref/conf-file.html?highlight=max-substitution-jobs#conf-cores

      # Downloads
      # https://nix.dev/manual/nix/2.24/command-ref/conf-file.html?highlight=max-substitution-jobs#conf-max-substitution-jobs
      max-substitution-jobs = lib.mkDefault 24;
      # https://nix.dev/manual/nix/2.32/command-ref/conf-file.html#conf-http-connections
      http-connections = lib.mkDefault 50;
      # https://nix.dev/manual/nix/2.24/command-ref/conf-file.html#conf-connect-timeout
      # Corresponds to curl's --connect-timeout.
      connect-timeout = lib.mkDefault 5;
      # https://nix.dev/manual/nix/2.24/command-ref/conf-file.html?highlight=max-substitution-jobs#conf-download-attempts
      download-attempts = lib.mkDefault 3;
    };

    extraOptions = ''
      # Ensure we can still build when a server is not accessible
      fallback = true
    '';

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };
}
