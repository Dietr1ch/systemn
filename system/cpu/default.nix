{ lib, pkgs, ... }:

{
  imports = [
    # ./corectrl.nix
    # ./scx.nix
  ];

  environment = {
    # NOTE: cpufrequtils doesn't build on aarch64
    systemPackages = lib.optionals pkgs.stdenv.hostPlatform.isx86_64 [
      pkgs.cpufrequtils
      ]; # ..environment.systemPackages
  }; # ..environment
}
