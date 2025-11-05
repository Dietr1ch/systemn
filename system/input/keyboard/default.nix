{ lib, ... }:

{
  services = {
    xserver = {
      exportConfiguration = true;
      xkb = {
        options = lib.strings.concatStringsSep ", " [
          "compose:ralt"
          "caps:ctrl_modifier"
          "grp_led:caps"
          "grp:shifts_toggle"
        ];
      };
    };
  };
}
