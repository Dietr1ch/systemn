{ pkgs, ... }:

{
  imports = [
    ./fonts.nix

    ./login-sddm.nix
    ./plasma.nix
  ];

  services = {
    colord = {
      enable = true;
    };
  };
}

