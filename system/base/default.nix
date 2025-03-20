{ ... }:

{
  imports = [
    ./identity.nix

    ./information.nix
    ./editor.nix
    ./nix.nix
    ./preload.nix
    ./tools.nix

    # ./hardware_information.nix
  ];

  # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/services/system/dbus.nix
  services.dbus.implementation = "broker";
}
