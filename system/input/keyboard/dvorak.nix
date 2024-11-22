{ config, lib, pkgs, ... }:

{
  console = {
    keyMap = "dvorak-programmer";
  };

  services = {
    xserver = {
      xkb = {
        layout = "us";
        variant = "dvp";
        options = "compose:ralt, caps:ctrl_modifier, grp_led:caps, grp:shifts_toggle";
      };
    };
  };
}
