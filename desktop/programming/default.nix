{ ... }:

{
  imports = [
    ./c.nix
    ./cpp.nix
    ./haskell.nix
    ./nix.nix
    ./python.nix
    ./rpc.nix
    ./rust.nix
    ./sql.nix
    ./web.nix

    ./build.nix
    ./debugging.nix
  ];
}
