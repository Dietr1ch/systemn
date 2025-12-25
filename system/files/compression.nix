{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      # In sync with ~/Projects/nixland/core/compression.nix
      arj
      brotli
      lbzip2
      lrzip
      pbzip2
      pigz
      pixz
      unzip
      xz
      zip
    ];
  };
}
