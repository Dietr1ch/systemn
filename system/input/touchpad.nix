{ config, lib, pkgs, ... }:

{
  services = {
    libinput = {
      enable = true;

      touchpad = {
        accelProfile = "adaptive";

        naturalScrolling = true;
        horizontalScrolling = true;

        tapping = true;
        middleEmulation = true;

        disableWhileTyping = true;
      };
    };
  };
}
