{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      arj
      lrzip
      pbzip2
      pigz
      pixz
      xz
      zip
    ];
  };
}
