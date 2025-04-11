{ ... }:

{
  imports = [
    ./identity.nix

    ./editor.nix
    ./information.nix
    ./nix.nix
    ./preload.nix
    ./tools.nix
    # TODO ./tracing.nix once it builds

    # ./hardware_information.nix
  ];

  # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/services/system/dbus.nix
  services.dbus.implementation = "broker";
}
