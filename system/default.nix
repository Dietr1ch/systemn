{ ... }:

{
  imports = [
    ./base
    ./boot
    ./cpu
    ./files
    ./input
    ./memory
    ./networking
    ./security
    ./storage

    ./crypto.nix
    ./hardware-update.nix
  ];
}
