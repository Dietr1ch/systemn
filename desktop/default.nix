{ config, lib, pkgs, ... }:

{
  imports = [
    ./shell  # ./shell/default.nix
    ./gaming  # ./gaming/default.nix

    ./sound.nix
  ];
}