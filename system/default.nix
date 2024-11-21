{ config, lib, pkgs, ... }:

{
  imports = [
    ./base        # ./base/default.nix
    ./boot        # ./boot/default.nix
    ./input       # ./input/default.nix
    ./networking  # ./networking/default.nix
    ./storage     # ./storage/default.nix

    ./shell.nix
  ];
}
