{ ... }:

{
  # https://search.nixos.org/options?channel=unstable&query=nix
  nix = {
    optimise = {
      automatic = true;
    };

    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];

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
