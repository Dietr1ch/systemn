{ pkgs, ... }:

{
  imports = [
    ./fonts.nix

    ./login-sddm.nix

    # ./hyprland.nix
    ./plasma.nix
  ];

  services = {
    colord = {
      enable = true;
    };
  };
}

