{ pkgs, ... }:

{
  imports = [
    ./config

    ./android.nix
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
    ./formatting.nix
    ./grammars.nix
  ];

  environment = {
    systemPackages = with pkgs; [
      ast-grep
    ]; # ..environment.systemPackages
  }; # ..environment
}
