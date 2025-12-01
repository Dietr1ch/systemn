{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      qpwgraph

      tuxguitar

      ardour
    ];
  };
}
