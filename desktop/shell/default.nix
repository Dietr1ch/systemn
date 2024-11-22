{ pkgs, ... }:

{
  imports = [
    ./graphical  # ./graphical/default.nix
    ./terminal   # ./terminal/default.nix
  ];
}

