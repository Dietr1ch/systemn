{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      libreoffice-fresh
      kdePackages.okular

      pandoc
    ];
  };
}
