{ pkgs, ... }:

{
  imports = [
    # ./leap.nix
    ./mouse.nix
    ./touchpad.nix
  ];

  environment = {
    systemPackages = with pkgs; [
      libinput
    ]; # ..environment.systemPackages
  }; # ..environment
}
