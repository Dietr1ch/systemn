{ config, lib, pkgs, ... }:

{
  services = {
    kubo = {
      enable = true;

      autoMount = true;
      startWhenNeeded = true;
      enableGC = true;
    };
  };
}
