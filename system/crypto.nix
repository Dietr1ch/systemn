{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      cryfs
      cryptsetup
    ];
  };
}
