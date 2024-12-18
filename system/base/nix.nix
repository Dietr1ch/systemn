{ lib, ... }:

{
  # https://search.nixos.org/options?channel=unstable&query=nix
  nix = {
    optimise = {
      automatic = true;
    };

    # https://nix.dev/manual/nix/2.24/command-ref/conf-file.html
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      connect-timeout = lib.mkDefault 2;

      # ../../secrets.nix
      # substituters = [
      # ];
      # trusted-public-keys = [
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
