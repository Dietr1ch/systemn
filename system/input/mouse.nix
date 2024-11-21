{ config, lib, pkgs, ... }:

{
  services = {
    libinput = {
      enable = true;

      mouse = {
        accelProfile = "flat";
        accelSpeed = "0.0";

        naturalScrolling = false;
      };
    };
  };
}
