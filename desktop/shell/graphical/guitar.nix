{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      tuxguitar
    ];
  };
}
