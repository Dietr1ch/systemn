{ config, lib, pkgs, ... }:

{
  imports = [
    # ./efi.nix
    ./plymouth.nix
    # ./silent.nix
  ];
}
