{ ... }:

{
  imports = [
    ./base # ./base/default.nix
    ./base/hardware_information.nix
    ./boot # ./boot/default.nix
    ./files # ./files/default.nix
    ./input # ./input/default.nix
    ./networking # ./networking/default.nix
    ./security # ./security/default.nix
    ./storage # ./storage/default.nix

    ./cpu.nix
    ./hardware-update.nix
    ./memory.nix
  ];
}
