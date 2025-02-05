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
}
