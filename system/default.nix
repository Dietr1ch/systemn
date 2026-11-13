{ ... }:

{
  imports = [
    ./base # ./base/default.nix
    ./boot # ./boot/default.nix
    ./cpu # ./cpu/default.nix
    ./files # ./files/default.nix
    ./input # ./input/default.nix
    ./memory # ./memory/default.nix
    ./networking # ./networking/default.nix
    ./security # ./security/default.nix
    ./storage # ./storage/default.nix

    ./crypto.nix
    ./hardware-update.nix
  ];
}
