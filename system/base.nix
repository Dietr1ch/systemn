{ config, lib, pkgs, ... }:

{
  imports = [
    ./base/nix.nix
    ./base/identity.nix
    ./base/information.nix
  ];
}
