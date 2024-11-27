{ config, lib, pkgs, ... }:

{
  imports = [
    ./base.nix

    ./podman.nix
    ./virtd.nix
  ];
}
