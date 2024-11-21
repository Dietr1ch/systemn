{ config, lib, pkgs, ... }:

{
  imports = [
    ./nix.nix
    ./identity.nix
    ./information.nix

    ./preload.nix
  ];
}
