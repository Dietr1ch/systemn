{ config, lib, pkgs, ... }:

{
  imports = [
    ./base  # ./base/default.nix
    ./boot  # ./boot/default.nix

    ./shell.nix
  ];
}
