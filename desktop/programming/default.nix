{ pkgs, ... }:

{
  imports = [
    ./config

    ./asp.nix
    ./c.nix
    ./cpp.nix
    ./fish.nix
    ./haskell.nix
    ./nix.nix
    ./python.nix
    ./rpc.nix
    ./rust.nix
    ./web.nix
    # ./zig.nix

    ./build.nix
    ./databases.nix
    ./debugging.nix
    ./grammars.nix
  ];
}
