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
    # ./zig.nix

    ./build.nix
    ./debugging.nix
    ./grammars.nix
  ];
}
