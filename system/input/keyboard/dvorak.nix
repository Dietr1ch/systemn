{ config, lib, pkgs, ... }:

{
  console = {
    keyMap = "dvorak-programmer";
  };
  services = {
    xserver = {
      exportConfiguration = true;
      xkb = {
        layout = "us";
        variant = "dvp";
        options = "compose:ralt, caps:ctrl_modifier, grp_led:caps, grp:shifts_toggle";
      };
    };
  };
}
