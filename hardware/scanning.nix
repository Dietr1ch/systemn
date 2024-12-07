{ pkgs, ... }:

{
  hardware = {
    sane = {
      enable = true;
    };
  };

  nixpkgs = {
    config = {
      packageOverrides = pkgs: {
        xsaneGimp = pkgs.xsane.override {
          gimpSupport = true;
        };
      };
    };
  };
}
