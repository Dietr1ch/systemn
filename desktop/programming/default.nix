{ ... }:

{
  imports = [
    ./c.nix
    ./cpp.nix
    ./haskell.nix
    ./python.nix
    ./rpc.nix
    ./rust.nix
    ./sql.nix
    ./web.nix

    ./build.nix
  ];
}
