{ config, lib, pkgs, ... }:

{
  imports = [
    ./base        # ./base/default.nix
    ./boot        # ./boot/default.nix
    ./input       # ./input/default.nix
    ./networking  # ./networking/default.nix
    ./security    # ./security/default.nix
    ./storage     # ./storage/default.nix

    ./memory.nix
    ./hardware-update.nix
  ];
}
