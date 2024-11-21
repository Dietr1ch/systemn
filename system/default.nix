{ config, lib, pkgs, ... }:

{
  imports = [
    ./base     # ./base/default.nix
    ./boot     # ./boot/default.nix
    ./storage  # ./storage/default.nix

    ./shell.nix
  ];
}
