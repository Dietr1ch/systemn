{ pkgs, ... }:

{
  environment = {
    # Packages in sync with ~/Projects/nixland/programming/rpc.nix
    systemPackages = with pkgs; [
      # gRPC
      grpc-tools
      protobuf-language-server
    ]; # ..environment.systemPackages
  }; # ..environment
}
