{ lib, ... }:

{
  networking = {
    # ../../secrets.nix
    # hostName = "potato";
    domain = lib.mkDefault "local";
  };
}
