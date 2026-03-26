{ pkgs, ... }:

{
  imports = [
    ./c.nix
    ./cpp.nix
    ./fish.nix
    ./haskell.nix
    ./nix.nix
    ./python.nix
    ./rpc.nix
    ./rust.nix
    ./sql.nix
    ./web.nix
    # ./zig.nix

    ./build.nix
    ./databases.nix
    ./debugging.nix
    ./grammars.nix
  ];

  environment = {
    # Packages in sync with ~/Projects/nixland/programming/default.nix
    systemPackages = with pkgs; [
      # Tools
      tokei
    ]; # ..environment.systemPackages
  }; # ..environment
}
