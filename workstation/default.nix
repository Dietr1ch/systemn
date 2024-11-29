{ config, lib, pkgs, ... }:

{
  imports = [
    ./virtualisation  # ./virtualisation/default.nix

    ./power.nix
    ./database/postgres.nix
  ];
}
