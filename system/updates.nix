{ lib, ... }:

{
  system = {
    # https://search.nixos.org/options?channel=unstable&query=system.autoUpgrade
    # ~/Projects/nixpkgs/nixos/modules/tasks/auto-upgrade.nix
    autoUpgrade = {
      enable = true;

      dates = lib.mkDefault "02:30";
      randomizedDelaySec = "25min";

      allowReboot = lib.mkDefault true;
      rebootWindow = {
        lower = "04:00";
        upper = "05:00";
      };

      flake = lib.mkDefault "/etc/nixos";
      # man nix3-flake-update(1)
      flags = [
        "--print-build-logs"
        "--commit-lock-file"
      ];

      runGarbageCollection = true;
    };
  };
}
