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

  environment = {
    systemPackages = with pkgs; [
      kdePackages.skanlite
    ];
  };
}
