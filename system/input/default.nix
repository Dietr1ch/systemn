{ config, lib, pkgs, ... }:

{
  imports = [
    ./mouse.nix
    ./touchpad.nix
    ./keyboard.nix
  ];
}
