{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      qpwgraph

      # BROKEN: kdePackages.k3b

      # BROKEN: audacity
      ardour
    ];
  };
}
