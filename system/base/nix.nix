{ lib, ... }:

{
  # https://search.nixos.org/options?channel=unstable&query=nix
  nix = {
    optimise = {
      automatic = true;
    };

    # Generates /etc/nix/nix.conf
    # https://nix.dev/manual/nix/2.24/command-ref/conf-file.html#available-settings
    settings = {
      auto-optimise-store = true;
      extra-experimental-features = [
        "nix-command" # https://nix.dev/manual/nix/2.32/development/experimental-features.html#xp-feature-nix-command
        "flakes" # https://nix.dev/manual/nix/2.32/development/experimental-features.html#xp-feature-flakes
        "cgroups" # https://nix.dev/manual/nix/2.32/development/experimental-features.html#xp-feature-cgroups
      ];

      # https://nix.dev/manual/nix/2.24/command-ref/conf-file.html#conf-connect-timeout
      # Corresponds to curl's --connect-timeout.
      connect-timeout = lib.mkDefault 4;

      # https://nix.dev/manual/nix/2.24/command-ref/conf-file.html#conf-preallocate-contents
      preallocate-contents = lib.mkDefault true;

      # https://nix.dev/manual/nix/2.24/command-ref/conf-file.html#conf-use-cgroups
      use-cgroups = lib.mkDefault true;

      # ../../secrets.nix
      # extra-substituters = [
      # ];
      # extra-trusted-public-keys = [
      # ];
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
