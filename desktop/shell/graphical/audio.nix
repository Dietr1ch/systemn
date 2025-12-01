{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      qpwgraph

      tuxguitar
      kdePackages.k3b

      ardour
    ];
  };
}
