{ config, lib, pkgs, ... }:

{
  imports = [
    ./cgroups.nix
    ./limits.nix
  ];
}
