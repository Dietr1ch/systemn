{ ... }:

{
  imports = [
    ./base
    ./base/hardware_information.nix
    ./boot
    ./files
    ./input
    ./networking
    ./security
    ./storage

    ./cpu.nix
    ./memory.nix
    ./hardware-update.nix
  ];
}
